import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.workSansTextTheme(Theme.of(context).textTheme)),
      home: Scaffold(

        body: const NotificationTile(),

      ),
    );
  }
}

class NotificationTile extends StatefulWidget {
  const NotificationTile({super.key});

  @override
  NotificationTileState createState() => NotificationTileState();
}

class NotificationTileState extends State<NotificationTile> {
  final Spid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) =>
      Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: const Text('Notifications',),
        ),
        backgroundColor: Colors.deepPurple,

            ),
        body: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('requests').where('SPid',isEqualTo: (Spid)).orderBy('timestamp', descending: true,).snapshots(),
                      builder: (context,snapshot){

                        if (snapshot.hasData) {
                          final requests = snapshot.data!.docs;
                          List<Card> requestWidgets = [];
                          for (var request in requests!) {
                            final user = request['name'];
                            final job = request['workDescription'];
                            final status = request['status'];
                            final id = request.id;
                            final time = request['timestamp'];
                            final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000);
                            final locality = request['locality'];



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
                                controlAffinity: ListTileControlAffinity.leading,
                                collapsedBackgroundColor: Colors.white60,
                                textColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15))
                                ),
                                title: Text(user),
                                subtitle: Text(locality),
                                trailing: Text(
                                  date1.day.toString()+"-"+date1.month.toString()+"-"+date1.year.toString(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[700],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                children: <Widget>[

                                  ListTile(title:
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(job)),
                                  ),
                                  Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                              100, 10, 10, 10),
                                          child: OutlinedButton(

                                            child: Text(
                                              "Accept",
                                              style: TextStyle(fontSize: 15.0,
                                                color: Colors.white,),

                                            ),

                                            style: OutlinedButton.styleFrom(

                                                backgroundColor: Colors
                                                    .deepPurple,

                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(15)))),


                                            onPressed: () {
                                              FirebaseFirestore.instance.collection('requests').doc(id).update(
                                                  {
                                                    'status':'accepted',
                                                  }
                                              );
                                            },
                                          ),
                                        ),

                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0, 10, 10, 10),
                                          child: OutlinedButton(
                                            child: Text(
                                              "Reject",
                                              style: TextStyle(fontSize: 15.0,
                                                color: Colors.black,),
                                            ),

                                            style: ButtonStyle(

                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(30.0))),
                                            ),

                                            onPressed: () {
                                              FirebaseFirestore.instance.collection('requests').doc(id).update(
                                                  {
                                                    'status':'rejected',
                                                  }
                                              );
                                            },
                                          ),
                                        ),


                                      ]),


                                ],
                              ),

                            );
                            if (status=='sent') {
                              requestWidgets.add(messageWidget);
                            }

                          }
                          return  SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: requestWidgets,
                                ),
                              );


                        }
                        return Center(
                          child: Text("No new notifications", style: TextStyle(color: Colors.grey),),
                        );
                      },
                    ),
  );


}




