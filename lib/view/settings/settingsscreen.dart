// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mandeladrawing/methods/authmodels.dart';
import 'package:mandeladrawing/utils/mycolors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mandeladrawing/view/authview/login.dart';
import 'package:mandeladrawing/view/plans/showplans.dart';

import '../../subscription_screen.dart';

class SettingsScreen extends StatelessWidget {
  void _signOut() {
    FirebaseAuth.instance.signOut();
    Get.to(() => LoginPage());
  } //print('$user');

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    double fontSize;
    double title;
    double heading;

    // Adjust the font size based on the screen width
    if (screenWidth < 320) {
      fontSize = 13.0;
      title = 20;
      heading = 20; // Small screen (e.g., iPhone 4S)
    } else if (screenWidth < 375) {
      fontSize = 17.0;
      title = 28;

      heading = 21; // Medium screen (e.g., iPhone 6, 7, 8)
    } else if (screenWidth < 414) {
      fontSize = 19.0;
      title = 32;

      heading = 25; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    } else if (screenWidth < 600) {
      fontSize = 21.0;
      title = 36;

      heading = 27; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    } else {
      fontSize = 25.0;
      title = 40;

      heading = 30; // Extra large screen or unknown device
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings ",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 1 / 10,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            CupertinoIcons.left_chevron,
            color: Colors.black,
            size: 30,
          ),
        ),
        backgroundColor: appbg,
        elevation: 0,
      ),
      backgroundColor: appbg,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  selectedColor: Colors.white,
                  leading: Icon(
                    Icons.subscriptions,
                  ),
                  title: Text(
                    "Subscription",
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "Get unlimited access to all pictures and remove adds"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SubscriptionScreen()));
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  selectedColor: Colors.white,
                  leading: Icon(
                    Icons.star_rate_sharp,
                  ),
                  title: Text(
                    "Rate App ",
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  selectedColor: Colors.white,
                  leading: Icon(
                    Icons.ios_share_outlined,
                  ),
                  title: Text(
                    "Share App",
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  selectedColor: Colors.white,
                  leading: Icon(
                    Icons.security,
                  ),
                  title: Text(
                    "Privacy Policy ",
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    Get.to(() => Plans());
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  selectedColor: Colors.white,
                  leading: Icon(
                    CupertinoIcons.money_dollar_circle,
                  ),
                  title: Text(
                    "Buy Plans",
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  selectedColor: Colors.white,
                  leading: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.logout_rounded),
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
