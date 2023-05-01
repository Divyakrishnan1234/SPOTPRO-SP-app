import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:spotpro_customer/screens/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Editprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../provider/auth_provider.dart';
import 'messagingScreen.dart';
import 'mainpage.dart';
import 'welcome_screen.dart';
import 'translator.dart';

class ScrollListhome extends StatefulWidget {
  const ScrollListhome({
    super.key,
  });
  @override
  _ScrollListhomeState createState() => _ScrollListhomeState();
}

class _ScrollListhomeState extends State<ScrollListhome> {
  int confirmed = 0;
  int todays = 0;
  final SPid = FirebaseAuth.instance.currentUser!.uid;
  final _firestore = FirebaseFirestore.instance;

  void getlocation() async {
    late double latitude;
    late double longitude;
    final Spid = FirebaseAuth.instance.currentUser!.uid;
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print(position);

    FirebaseFirestore.instance.collection('providers').doc(Spid).update({
      'latlon': {
        'latitude': position.latitude,
        'longitude': position.longitude
      },
    });
  }

  createChatroom(String chatRoomID, chatRoomMap) {
    _firestore
        .collection("chatRoom")
        .doc(chatRoomID)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  createChatroomAndStartConversation(String username, String username2) {
    if (username != username2) {
      List<String> users = [username, username2];
      String chatRoomID = getChatRoomID(username, username2);
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomID": chatRoomID
      };
      createChatroom(chatRoomID, chatRoomMap);

      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: MessagingScreen(chatRoomID: chatRoomID),
        withNavBar: false, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.slideRight,
      );
    } else {
      print("Can't send yourself messages");
    }
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ap = Provider.of<AuthProvider>(context, listen: false);
    bool verified = ap.userModel.verified;
    return MaterialApp(
      theme: ThemeData(
          textTheme:
              GoogleFonts.workSansTextTheme(Theme.of(context).textTheme)),
      home: Scaffold(
        drawerScrimColor: Colors.white60.withOpacity(0.6),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
                child: Center(
                    child: Text('Welcome to SpotPro!',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
              ),
              ListTile(
                title: const Text('Select language'),
                onTap: () {
                  DialogExample(context);
                  setState(() {
                    String language = ap.userModel.ln;
                  });
                },
              ),
              ListTile(
                title: const Text('Edit profile'),
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: Editprofile(), withNavBar: false);
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () async {
                  final ap = Provider.of<AuthProvider>(context, listen: false);
                  Navigator.of(context, rootNavigator: true)
                      .popUntil((route) => route.isFirst);
                  ap
                      .userSignOut()
                      .then((value) => PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: WelcomeScreen(),
                            withNavBar:
                                false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.slideRight,
                          ));
                },
              ),
            ],
          ),
        ),
        key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('providers')
              .doc(ap.userModel.uid)
              .get(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              verified = snapshot.data!.data()!['verified'];
            }
            return Column(
              children: [
                Column(
                  children: [
                    Container(
                        color: Colors.deepPurple,
                        padding: EdgeInsetsDirectional.fromSTEB(10, 50, 10, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //const Text("Set availability",style: TextStyle(fontSize: 25,color: Colors.white60),),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Hi, " + ap.userModel.name + "!  ",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  verified
                                      ? Icon(
                                    Icons.verified_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                      : Tooltip(message: "Your profile is pending verification from admin.", child: Icon(

                                    Icons.hourglass_top,
                                    color: Colors.white,
                                    size: 20,
                                  ),)
                                ],
                              ),
                            ),

                            //Text("Verified",style: TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),

                            Spacer(),
                            IconButton(
                                onPressed: () => {
                                      scaffoldKey.currentState?.openDrawer(),
                                    },
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.white54,
                                  size: 25,
                                )),
                          ],
                        )),
                    Container(
                      color: Colors.deepPurple,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: size.height / 3.5,
                            width: size.width / 2.3,
                            child: Card(
                              color: Colors.deepPurple.shade400,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              borderOnForeground: true,
                              shadowColor: Colors.deepPurple,
                              elevation: 8.0,
                              child: Container(
                                padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 30.0,bottom: 30.0),
                                child: Column(
                                  children: [
                                    //Text(DateFormat("d MMMM").format(DateTime.now()).toString(),style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white) ),

                                    Text(
                                      Translate("Set your current location.",
                                          ap.userModel.ln),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white60),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 30),
                                      child: IconButton(
                                          onPressed: () {
                                            PersistentNavBarNavigator
                                                .pushNewScreen(
                                              context,
                                              screen: LocationPickerScreen(),
                                              withNavBar:
                                                  false, // OPTIONAL VALUE. True by default.
                                              pageTransitionAnimation:
                                                  PageTransitionAnimation
                                                      .slideRight,
                                            );
                                          },
                                          icon: Icon(
                                            Icons.location_on,
                                            size: 50,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: size.height / 3.5,
                            width: size.width / 2.3,
                            child: Card(
                              color: Colors.deepPurple.shade400,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              borderOnForeground: true,
                              shadowColor: Colors.deepPurple,
                              elevation: 8.0,
                              child: Container(
                                padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 60.0,bottom: 50.0),
                                child: Column(
                                  children: [

                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width,

                                      ),
                                      child: Text(
                                        Translate("My Bookings", ap.userModel.ln),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70),
                                      ),
                                    ),
                                    Spacer(),

                                    Text(
                                      confirmed.toString(),
                                      style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    padding: EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Translate("Confirmed Bookings", ap.userModel.ln),
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    )),
                Divider(),
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('requests')
                      .where('SPid', isEqualTo: (SPid))
                      .orderBy(
                        'timestamp',
                        descending: true,
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final requests = snapshot.data!.docs;
                      List<Card> requestWidgets = [];
                      for (var request in requests!) {
                        final user = request['name'];
                        final job = request['workDescription'];
                        final status = request['status'];
                        final id = request.id;
                        final time = request['timestamp'];
                        final DateTime date1 =
                            DateTime.fromMillisecondsSinceEpoch(
                                time.seconds * 1000);
                        final locality = request['locality'];
                        final UserID = request['SCid'];
                        final latitude = request['latlon']['latitude'];
                        final longitude = request['latlon']['longitude'];
                        final scheduled = request['scheduled'];

                        final messageWidget = Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          borderOnForeground: true,
                          shadowColor: Colors.deepPurple,
                          elevation: 0.0,
                          child: ExpansionTile(
                            textColor: Colors.black,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(user),
                            subtitle: Text(locality),
                            trailing: Text(
                              DateFormat("d MMMM")
                                  .format(scheduled.toDate())
                                  .toString(),
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            children: <Widget>[
                              ListTile(
                                title: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      job,
                                      style: TextStyle(fontSize: 14),
                                    )),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    IconButton(
                                        onPressed: () async {
                                          final DocumentSnapshot<
                                                  Map<String, dynamic>>
                                              userDoc = await FirebaseFirestore
                                                  .instance
                                                  .collection('users')
                                                  .doc(UserID)
                                                  .get();

                                          final String phoneNumber =
                                              userDoc.get('phoneNumber');
                                          Uri phoneno =
                                              Uri.parse('tel:$phoneNumber');
                                          if (await launchUrl(phoneno)) {
                                            //dialer opened
                                          } else {
                                            //dailer is not opened
                                          }
                                        },
                                        icon: Icon(Icons.phone_outlined,
                                            color: Colors.deepPurple,
                                            size: 30)),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () async {
                                          final String googleMapsUrl =
                                              'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
                                          if (await canLaunchUrlString(
                                              googleMapsUrl)) {
                                            await launchUrlString(
                                                googleMapsUrl);
                                          } else {
                                            throw 'Could not launch $googleMapsUrl';
                                          }
                                        },
                                        icon: Icon(Icons.location_on_sharp,
                                            color: Colors.deepPurple,
                                            size: 30)),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () async {
                                          final DocumentSnapshot<
                                                  Map<String, dynamic>>
                                              userDoc = await FirebaseFirestore
                                                  .instance
                                                  .collection('users')
                                                  .doc(UserID)
                                                  .get();
                                          print(userDoc.id);
                                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>GoToMessagingScreen(recieverID:userDoc.id)));
                                          createChatroomAndStartConversation(
                                              SPid, userDoc.id);
                                        },
                                        icon: Icon(Icons.message_rounded,
                                            color: Colors.deepPurple,
                                            size: 30)),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                          onPressed: () {
                                            requestDialog(context, id);
                                          },
                                          icon: Icon(CupertinoIcons.trash_fill,
                                              color: Colors.deepPurple,
                                              size: 30)),
                                    ),
                                    Spacer(),
                                  ]),
                            ],
                          ),
                        );
                        if (status == 'accepted') {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            confirmed = requestWidgets.length;
                            setState(() {});
                          });

                          requestWidgets.add(messageWidget);
                        }
                      }
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: requestWidgets,
                        ),
                      );
                    }
                    return Text("No new bookings");
                  },
                )),
                SizedBox(
                  height: 50,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  DialogExample(context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a language.'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Select a language of your preference.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                ap.userModel.ln = "en";
                Navigator.pop(context, 'en');
              },
              child: const Text('English'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  ap.userModel.ln = "ml";
                });
                Navigator.pop(context, 'ml');
              },
              child: const Text('Malayalam'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  ap.userModel.ln = "hi";
                });

                Navigator.pop(context, 'hi');
              },
              child: const Text('Hindi'),
            ),
          ],
        );
      },
    );
  }
}

_makingPhoneCall() async {
  var url = Uri.parse("tel:9776765434");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
    print('call');
  } else {
    print('cannot call');
  }
}

Future<bool?> requestDialog(context, String id) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Do you want to cancel the booking?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              FirebaseFirestore.instance.collection('requests').doc(id).update({
                'status': 'cancelled',
              });

              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

getChatRoomID(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
