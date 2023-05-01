import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:spotpro_customer/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotpro_customer/screens/Editprofile.dart';
import 'translator.dart';

class SpProfile extends StatelessWidget {
  const SpProfile({Key? key}) : super(key: key);

  static const String _title = 'SpotPro';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
          textTheme:
              GoogleFonts.workSansTextTheme(Theme.of(context).textTheme)),
      home: Scaffold(
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>{
  late bool forAndroid = true;


  @override
  void initState() {
    super.initState();
    //routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }




  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final String review =(ap.userModel.review['1'] != 0)? (ap.userModel.review['2'] / ap.userModel.review['1'])
        .toStringAsFixed(1) : '0.0';


    ValueNotifier<bool> _notifier = ValueNotifier(false);
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: ValueListenableBuilder(
                valueListenable: _notifier,
                builder: (BuildContext context, bool val, Widget? child) {
                  return (ap.userModel.image != "")
                      ? Image.network(
                    ap.userModel.image,
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          "https://www.cleanlink.com/resources/editorial/2020/26237-tools.png",
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        );
                },
              ),
            ),
            Container(
              alignment: FractionalOffset.centerLeft,
              child: Text(ap.userModel.service),
              padding: EdgeInsets.only(left: 15, top: 3),
            ),
            // Text(ap.userModel.name),
            // Text(ap.userModel.phoneNumber),
            // Text(ap.userModel.email),
            ListTile(
              title: Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Text(
                    ap.userModel.name,
                    style: TextStyle(fontSize: 20),
                  )),
              subtitle: Text(
                "Rs " + ap.userModel.rate.toString() + "/hr",
                style: TextStyle(fontSize: 16),
              ),
              minVerticalPadding: 4.0,
            ),

            ListTile(
                title: Text(
                  (Translate("Rating", ap.userModel.ln)),
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Wrap(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      review,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )),
            ListTile(
              title: Row(
                children: [
                  Text(
                    (Translate("Description", ap.userModel.ln)),
                    style: TextStyle(fontSize: 16),
                  ),
                  //IconButton(onPressed:(){}, icon: Icon(Icons.edit)),
                ],
              ),
              subtitle: Text(ap.userModel.desc),
            ),
            ListTile(
              title: Text(Translate("Available At:", ap.userModel.ln)),
              subtitle: Text(ap.userModel.location),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.5, left: 15, right: 15),
              child: Divider(thickness: 2),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: Row(
                children: [
                  Text(
                    Translate("Set Availabilty", ap.userModel.ln),
                  ),
                  Spacer(),
                  Switch(
                    // thumb color (round icon)
                    activeColor: Colors.deepPurple,
                    activeTrackColor: Colors.grey,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey.shade400,
                    splashRadius: 50.0,
                    // boolean variable value

                    value: forAndroid,
                    // changes the state of the switch
                    //onChanged: (value) => setState(() => forAndroid = value)
                    onChanged: (value) async {
                      {
                        FirebaseMessaging messaging =
                            FirebaseMessaging.instance;

                        // Get the FCM token
                        String? fcmToken = await messaging.getToken();
                        String user_id = FirebaseAuth.instance.currentUser!.uid;
                        print(fcmToken);
                        DocumentReference user_ref = FirebaseFirestore.instance
                            .collection('providers')
                            .doc(user_id);

                        user_ref.update({'token': fcmToken});

                        messaging.onTokenRefresh.listen((String? newToken) {
                          user_ref.update({'token': fcmToken});
                        });
                      }
                      setState(() {
                        forAndroid = value;
                        print(forAndroid);
                        FirebaseFirestore.instance
                            .collection('providers')
                            .doc(ap.userModel.uid)
                            .update({
                          'available': forAndroid,
                        });
                      });
                    },
                  ),
                ],
              ),
            ),

            ListTile(title: Text(Translate('Reviews', ap.userModel.ln))),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('reviews')
                  .where('SPid', isEqualTo: ap.userModel.uid)
                  .orderBy('createdAt')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final reviews = snapshot.data!.docs;
                  List<Widget> reviewWidgets = [];
                  for (var review in reviews) {
                    ListTile card = ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor: Color(0xFFC9C5C5).withOpacity(0.4),
                        leading: Icon(
                          Icons.person,
                          size: 50,
                        ),
                        title: Text(
                          review['SCname'],
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          review['text'],
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        trailing: Wrap(
                          children: [
                            Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.deepPurple,
                            ),
                            Text(
                              review['rating'].toString(),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ));
                    reviewWidgets.add(card);
                  }

                  return CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 10,
                      scrollPhysics: ScrollPhysics(),
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                    ),
                    items: reviewWidgets,
                  );
                } else {
                  return Container(
                    child: Center(
                      child: Text(Translate("No reviews yet.", ap.userModel.ln),
                          style: TextStyle(color: Colors.grey)),
                    ),
                  );
                }
              },
            ),
            ElevatedButton(
                onPressed: ()  {
                   PersistentNavBarNavigator.pushNewScreen(context,
                      screen: Editprofile(), withNavBar: false);
                },
                child: Text(
                  Translate("Edit Profile >", ap.userModel.ln),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.deepPurple))
          ],
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
