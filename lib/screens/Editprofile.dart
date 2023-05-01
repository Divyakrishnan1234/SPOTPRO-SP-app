import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotpro_customer/screens/spprof.dart';
import 'package:flutter/material.dart';
import 'package:spotpro_customer/model/sp_model.dart';
import 'package:spotpro_customer/provider/auth_provider.dart';
import 'package:spotpro_customer/screens/mainpage.dart';
import 'package:spotpro_customer/screens/home_screen.dart';
import 'package:spotpro_customer/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:spotpro_customer/screens/promoimages.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'spprof.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  // File? image;

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final descController = TextEditingController();
  final serviceController = TextEditingController();
  final rateController = TextEditingController();

String dpUrl="";



  @override

  void initState() {
    super.initState();
    Timer.run(() {
      final ap = Provider.of<AuthProvider>(context, listen: false);


      nameController.text=ap.userModel.name;
      locationController.text=ap.userModel.location;
      descController.text=ap.userModel.desc;
      rateController.text=ap.userModel.rate.toString();


    });}

  @override
  final List<bool> _selectedFruits = <bool>[true, false];
  bool vertical = false;
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final SPid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text("Edit profile"),backgroundColor: Colors.deepPurple),

        body:
        SingleChildScrollView(
          child: Column(
            children: [

              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 15),
                margin: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //  Center(child:Text("Profile image")),
                      Center(child:IconButton(onPressed:(){
                      //   ImagePicker imagepicker=ImagePicker();
                      //   XFile? file=await imagepicker.pickImage(source: ImageSource.gallery);
                      //   if (file!=null)  {
                      //     Reference referenceRoot=FirebaseStorage.instance.ref();
                      //     Reference  referenceDirImages=referenceRoot.child("Profile pic");
                      //     Reference referenceImageToUpload=referenceDirImages.child('${file?.name}');
                      //     try{
                      //       await referenceImageToUpload.putFile(File(file!.path));
                      //       dpUrl=await referenceImageToUpload.getDownloadURL();
                      //       print(dpUrl);
                      // //      ap.userModel.image=dpUrl;
                      //     }
                      //     catch(error){
                      //
                      //     }
                      //   }
                        }, icon: Icon(Icons.person_pin_outlined,color: Colors.grey,size: 50,))),

                      Text("Full Name"),
                      textFeld(
                        //  initial: ap.userModel.name,

                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: nameController,
                      ),

                      Text("Location"),
                      textFeld(
                        //   initial: ap.userModel.location,
                        icon: Icons.location_on_sharp,
                        inputType: TextInputType.emailAddress,
                        maxLines: 1,
                        controller: locationController,
                      ),
                      Text("Job description"),
                      textFeld(
                        // initial: ap.userModel.desc,
                        icon: Icons.description_sharp,
                        inputType: TextInputType.text,
                        maxLines: 2,
                        controller: descController,
                      ),
                      Text("Rate per hour"),

                      textFeld(
                        //   initial: ap.userModel.rate+ "Rs",
                        icon: Icons.currency_rupee,
                        inputType: TextInputType.text,
                        maxLines: 1,
                        controller: rateController,

                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // ToggleButtons with a single selection.
                            Text('Select Privacy Setting',textAlign: TextAlign.left,),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: ToggleButtons(borderWidth: 1.5,
                                  direction: vertical ? Axis.vertical : Axis.horizontal,
                                  onPressed: (int index) {
                                    setState(() {
                                      print(index);
                                      // The button that is tapped is set to true, and the others to false.
                                      for (int i = 0; i < _selectedFruits.length; i++) {
                                        _selectedFruits[i] = i == index;
                                      }
                                      int pressed = -1;
                                      for (int i = 0; i < _selectedFruits.length; i++) {
                                        if(_selectedFruits[i] == true) pressed = i;
                                      }

                                      if(pressed==0){
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                            title: const Text('Public'),
                                            content: const Text('Your profile has been set to public'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                        // AlertDialog(
                                        //   title: Text('Sucess'),
                                        //   content: Text('Your profile has been set to Public'),
                                        //   actions: <Widget>[
                                        //     TextButton(
                                        //       child: Text('OK'),
                                        //       onPressed: () => Navigator.of(context).pop(),
                                        //     ),
                                        //   ],
                                        // );
                                        FirebaseFirestore.instance.collection('providers').doc(SPid).update(
                                            {
                                              'privacy':'public',
                                            }
                                        );
                                      }
                                      if(pressed==1){
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                            title: const Text('On Request'),
                                            content: const Text('Information sharing is only when you accept a request'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );

                                        FirebaseFirestore.instance.collection('providers').doc(SPid).update(
                                            {
                                              'privacy':'on request',
                                            }


                                        );
                                      }
                                      // if(pressed==2){
                                      //   showDialog<String>(
                                      //     context: context,
                                      //     builder: (BuildContext context) => AlertDialog(
                                      //       title: const Text('Message'),
                                      //       content: const Text('You are currently available only on message'),
                                      //       actions: <Widget>[
                                      //         TextButton(
                                      //           onPressed: () => Navigator.pop(context, 'Cancel'),
                                      //           child: const Text('OK'),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   );
                                      //   FirebaseFirestore.instance.collection('providers').doc(SPid).update(
                                      //       {
                                      //         'privacy':'message',
                                      //       }
                                      //   );
                                      // }
                                    });
                                  },
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  selectedBorderColor: Colors.deepPurple,
                                  selectedColor: Colors.deepPurple,
                                  fillColor: Colors.purple.shade50,
                                 // focusColor:  Colors.purple.shade50,
                                  disabledColor: Colors.purple.shade50,
                                 // color: Colors.deepPurple[400],
                                  constraints: const BoxConstraints(
                                    minHeight: 40.0,
                                    minWidth: 80.0,
                                  ),
                                  isSelected: _selectedFruits,
                                  children: privacy,

                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                      SizedBox(height:10),
                      Center(child: ElevatedButton(onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Promoimages()));
                      }, style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),child:
                      Text("Upload promotion images"),))

                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(

                      text: "Save",
                      onPressed: () {
                        if  ((nameController.text=="") || (descController.text=="")||(locationController.text=="")||(rateController.text==""))
                        {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                  title: const Text("Alert Dialog Box"),
                                  content: const Text("Please fill all the fields"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) => const SpProfile()),
                                        // );
                                      },
                                      child: Container(
                                        color: Colors.deepPurple,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("okay",style: TextStyle(color:Colors.white),),
                                      ),
                                    ),
                                  ]
                              ));


                        }
                        else {
                          storeData();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Data saved successfully!")));

                         //Navigator.pop(context);
                        }
                        }
                  ),

                  //SizedBox(width:2),
                  CustomButton(


                      text: "Cancel",
                      onPressed: () {
                        Navigator.pop(context);
                      }
                  ),


                ],
              )
            ],
          ),
        )


    );
  }

  Widget textFeld({

    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
    // required String initial
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        // initialValue: initial,
        cursorColor: Colors.deepPurple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.deepPurple,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),

          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.purple.shade50,
          filled: true,
        ),
      ),
    );
  }

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    // urllist=Promoimages.
    //
    //  await firebaseFirestore
    //     .collection("providers").doc(ap.userModel.uid)
    //     .set({'downloadURL': promourls},SetOptions(merge: true)).then((value) => showSnackBar("Image Uploaded", Duration(seconds: 2)));
    UserModel userModel = UserModel(
      available: ap.userModel.available
        ,
      //promourl: [],
        url: ap.userModel.url,
        ln:ap.userModel.ln,
        verified: ap.userModel.verified,
        image: dpUrl,
        name: nameController.text.trim(),
        location: locationController.text.trim(),
        createdAt: "",
        phoneNumber: "",
        uid: "",
        service: ap.userModel.service,
        desc:descController.text,
        rate: rateController.text,
        review:ap.userModel.review
    );

    ap.saveUserDataToFirebase(
      context: context,
      // id: image!,

      userModel: userModel,
      onSuccess: () {
        ap.saveUserDataToSP().then(
              (value) => ap.setSignIn().then(
                (value) => Navigator.pop(context),
          ),
        );
      },
    );

  }
  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    locationController.dispose();
    rateController.dispose();
    super.dispose();
  }
}
const List<Widget> privacy = <Widget>[
  Text('Public'),
  Text(' On Request '),
];