// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mandeladrawing/view/authview/authhome.dart';
import 'package:mandeladrawing/view/authview/login.dart';
import 'package:get/get.dart';
// Import dart:async for Timer

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay for 2 seconds before navigating to the next screen
    Timer(Duration(seconds: 5), () {
      // Replace the below code with your navigation logic
      Get.to(() => AuthHome());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Add your splash screen UI here
    return Material(
      child: Center(
        child: Image(
            fit: BoxFit.cover,
            height: 400,
            width: 400,
            image: AssetImage('assets/logo.png')),
      ),
    );
  }
}
