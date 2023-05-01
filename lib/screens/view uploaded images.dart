

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spotpro_customer/provider/auth_provider.dart';
import 'package:spotpro_customer/screens/promoimages.dart';

class DownloadUrlsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple, title: Text('Saved images')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('providers')
            .doc(ap.userModel.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var temp = snapshot.data!.data() as Map<String, dynamic>;

          // var temp = snapshot.data as Map<dynamic, dynamic>;
          if(temp == null || temp!.containsKey('downloadURL')) {
            List<dynamic> downloadUrls = snapshot.data!.get('downloadURL');
            List<String> downloadUrlStrings =
            downloadUrls.map((url) => url.toString()).toList();

            return ListView.builder(
              itemCount: downloadUrlStrings.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          height: 250,
                          width: 250,
                          imageUrl: downloadUrlStrings[index],
                          imageBuilder: (context, imageProvider) =>
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    alignment: Alignment.center,
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),),
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Center(child: Icon(Icons.error)),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          String url = downloadUrlStrings[index];
                          String fileName = url.split('%2F')[1].split('?')[0];

                          //String fileName = url.substring(url.lastIndexOf('/') + 1);
                          Reference storageRef = FirebaseStorage.instance.ref()
                              .child('Promoimages/$fileName');
                          var collection = FirebaseFirestore.instance
                              .collection(
                              'providers');
                          collection.doc(ap.userModel.uid).update(
                              {
                                'downloadURL': FieldValue.arrayRemove(
                                    [downloadUrlStrings[index]])
                              });
                          await storageRef.delete();
                        },
                      ),

                    ],
                  ),
                );
              },
            );
          }
          else {
            return Container(
              child: Center(
                child: Text('No images present.', style: TextStyle(color: Colors.grey),),
              ),
            );
          }

        },
      ),
    );


  }

}




