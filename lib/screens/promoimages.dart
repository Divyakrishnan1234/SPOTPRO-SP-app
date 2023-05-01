
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spotpro_customer/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spotpro_customer/screens/view uploaded images.dart';

class Promoimages extends StatefulWidget {
  final String? userId;
  const Promoimages({Key? key, this.userId}) : super(key: key);

  @override
  State<Promoimages> createState() => _PromoimagesState();
}

class _PromoimagesState extends State<Promoimages> {
  // initializing some values
  File? _image;
  final imagePicker = ImagePicker();
  String downloadURL="";

  // picking the image

  Future imagePickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar("No File selected", Duration(milliseconds: 400));
      }
    });
  }


  Future uploadImage(File _image,BuildContext context) async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final usersCollection = firebaseFirestore.collection('providers');
    final querySnapshot = await usersCollection.where('uid', isEqualTo: ap.userModel.uid).get();

    List<dynamic> promourls = [];

    for (final documentSnapshot in querySnapshot.docs) {
      // Check if the document exists and contains the 'downloadURL' field
      if (documentSnapshot.exists && documentSnapshot.data().containsKey('downloadURL')) {
        promourls = List<dynamic>.from(documentSnapshot.data()['downloadURL']);
      }

      final imgId = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('Promoimages').child(imgId);

      await reference.putFile(_image);
      downloadURL = await reference.getDownloadURL();

      // Add the downloadURL to the promourls list
      promourls.add(downloadURL);

      // Update the document in Firestore with the new promourls list
      await firebaseFirestore
          .collection("providers").doc(ap.userModel.uid)
          .set({'downloadURL': promourls}, SetOptions(merge: true))
          .then((value) => showSnackBar("Image Uploaded", Duration(seconds: 2)));
    }
  }



  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;




    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple,
        title: const Text("Upload Image "),

      ),

      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: Column(children: [

                      const Text("Upload Image",selectionColor: Colors.deepPurpleAccent),
                      const SizedBox(
                        height: 10,

                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.deepPurple),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // the image that we wanted to upload
                                Expanded(
                                    child: _image == null
                                        ? const Center(
                                        child: Text("No image selected"))
                                        : Image.file(_image!)),
                                ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                                    onPressed: () {
                                      imagePickerMethod();
                                    },
                                    child: const Text("Select Image")),
                                ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                                    onPressed: () {
                                      if (_image != null) {
                                        uploadImage(_image!,context);
                                        Fluttertoast.showToast(
                                            msg: 'Image uploaded successfully!',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            //timeInSecForIos: 1,

                                            backgroundColor: Colors.white,
                                            textColor: Colors.green
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'Select image first',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            //timeInSecForIos: 1,

                                            backgroundColor: Colors.grey,
                                            textColor: Colors.red
                                        );
                                      }
                                    },
                                    child: const Text("Upload Image")),
                                ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DownloadUrlsScreen()));

                                    },
                                    child: const Text("View saved Images")),
                              ],
                            ),
                          ),
                        ),
                      )
                    ])))),
      ),
    );
  }

  // show snack bar

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
