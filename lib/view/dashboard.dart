// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:mandeladrawing/methods/authmodels.dart';
import 'package:mandeladrawing/view/profile/profileview.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/sketchmodel.dart';
import '../models/usermodel.dart';
import 'colorpannel/viewmandelas.dart';
import '../widgets/create.dart';
import 'createpannel/drawpage.dart';
import 'library/mylibrary.dart';

class Home extends StatefulWidget {
  const Home({super.key, });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pgindex = 0;
  void selindex(int index) {
    setState(() {});
    pgindex = index;
  }

  // void storeData()async{
  //    final userId = FirebaseAuth.instance.currentUser!.uid;    
  //                       await FirebaseFirestore.instance.collection('users').doc(userId).set(user.toJson())
  //       .whenComplete(() => Get.snackbar(
  //           "Success", "Your Account has been successfuly created",
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.green.withOpacity(0.6),
  //           colorText: Colors.white))
  //       .catchError((error, stackTrace) {
  //     Get.snackbar("Error", "Something went wrong. Please try again",
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red.withOpacity(0.1),
  //         colorText: Colors.white);});
  // }

  final List<Widget> pages = [
    ViewMandelas(),
    DrawingPage(),
    MyLibrary(),
    ProfileView(),
  ];
  List<int> listofpages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedFontSize: 14,
            selectedItemColor: Colors.black,
            selectedFontSize: 16,
            selectedLabelStyle: TextStyle(color: Colors.black),
            iconSize: 30,
            onTap: selindex,
            currentIndex: pgindex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.color_lens,
                    color: Colors.grey,
                  ),
                  label: "fill Color"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.create,
                    color: Colors.grey,
                  ),
                  label: "Create"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.dashboard,
                  ),
                  label: "My Library"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  label: "Edit Profile")
            ]),
        body: pages[pgindex]);
  }
}
