// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mandeladrawing/controllers/profilecontroller.dart';
import 'package:mandeladrawing/methods/authmodels.dart';
import 'package:mandeladrawing/widgets/mybutton.dart';

import '../../models/usermodel.dart';
import '../../providers/userprovider.dart';
import '../../utils/mycolors.dart';
import '../dashboard.dart';
import 'editprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

String? documentId;

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference usersRef = firestore.collection('Users');
Future<void> getData() async {
  QuerySnapshot? users = await usersRef.get();
  if (users != null) {
    users.docs.forEach((doc) {
      print(doc.data());
    });
  }
}

class _ProfileViewState extends State<ProfileView> {
  String email = "";
  String fName = "";
  String lName = "";
  int num = 0;
  getInfo() async {
    var collection = FirebaseFirestore.instance.collection('Users');
    var docSnapshot = await collection.doc().get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        email = data?["Email"];
        fName = data?["First Name"];
        lName = data?["Last Name"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: appbar,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appbar,
          leading: IconButton(
              onPressed: () {
                Get.to(() => Home());
              },
              icon: Icon(
                CupertinoIcons.left_chevron,
                color: Colors.black,
              )),
          title: Text(
            email,
            style: TextStyle(fontSize: 26, color: appbartitle),
          ),
          actions: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                CupertinoIcons.settings,
                color: Colors.black,
                size: 30,
              ),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: StreamBuilder(
//                future: controller.getUserData(),
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(documentId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      final data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      final email = data['Email'] as String?;
                      print(email);
                      // UserModel userdata = snapshot.data as UserModel;
                      return Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Stack(children: [
                              const CircleAvatar(
                                radius: 80,
                                backgroundImage: AssetImage('assets/dp.jpg'),
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 1 / 40,
                          ),
                          Text(
                            '',
                            //                   user!.email,
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 1 / 20,
                          ),
                          TextFormField(
                            initialValue: documentId,
                            // user.email.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          TextFormField(
                            initialValue: email,
                            // user.email.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 1 / 7.5,
                          ),
                          MyCustomButton(
                              title: "Edit Profile",
                              borderrad: 25,
                              onaction: () {
                                Get.to(() => EditProfile());
                              },
                              color1: gd2,
                              color2: gd1,
                              width: MediaQuery.of(context).size.width - 40),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    // FirebaseAuthMethod().signOut();
                                  },
                                  icon: Icon(
                                    Icons.logout_rounded,
                                    color: red,
                                    size: 40,
                                  )),
                              const Text(
                                "Log out",
                                style: TextStyle(
                                    color: red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return Center(
                        child: Text("Something went wrong"),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )));
  }
}
