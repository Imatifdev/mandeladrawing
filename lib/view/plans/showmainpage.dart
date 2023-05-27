// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mandeladrawing/view/authview/login.dart';
import 'package:mandeladrawing/view/colorpannel/viewmandelas.dart';
import 'package:mandeladrawing/view/dashboard.dart';
import 'package:mandeladrawing/view/plans/showplans.dart';

import '../../utils/mycolors.dart';
import '../../widgets/mybutton.dart';
import '../authview/signup.dart';

class ShowingMainPage extends StatefulWidget {
  const ShowingMainPage({super.key});

  @override
  State<ShowingMainPage> createState() => _ShowingMainPageState();
}

class _ShowingMainPageState extends State<ShowingMainPage> {
  late StreamSubscription subscription;

  bool isDeviceConnected = false;

  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double fontSize;

    // Adjust the font size based on the screen width
    if (screenWidth < 320) {
      fontSize = 18.0; // Small screen (e.g., iPhone 4S)
    } else if (screenWidth < 375) {
      fontSize = 40.0; // Medium screen (e.g., iPhone 6, 7, 8)
    } else if (screenWidth < 414) {
      fontSize = 45.0; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    } else if (screenWidth < 600) {
      fontSize = 55.0; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    } else {
      fontSize = 60.0; // Extra large screen or unknown device
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              height: screenheight / 8,
              width: double.infinity,
              image: AssetImage(
                'assets/flow.png',
              ),
            ),
            SizedBox(
              height: screenheight / 12,
            ),
            Text(
              "Full Access",
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Get it now",
              style: TextStyle(
                  fontSize: 25, color: Colors.red, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => Home());
              },
              child: Text(
                "Or Continue with a limited version",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Enjoy Coluring 1000+ amazing pictures with any pallete you like , create countless mandlas with no add ",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "7 days  free trial and renewl at 2000 ksh on every year.  Cancel anytime atleast 24 hours before renewel  ",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MyCustomButton(
                width: MediaQuery.of(context).size.width - 70,
                title: "Try free and subscribe anually",
                borderrad: 50,
                onaction: () {
                  Get.to(() => Plans());
                },
                color1: gd2,
                color2: gd1),
            const SizedBox(
              height: 20,
            ),
            MyCustomButton(
                width: MediaQuery.of(context).size.width - 70,
                title: "View Packages",
                borderrad: 50,
                onaction: () {
                  Get.to(() => Plans());
                },
                color1: green,
                color2: green),
          ],
        ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
