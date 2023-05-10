// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mandeladrawing/methods/authmodels.dart';
import 'package:mandeladrawing/utils/mycolors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mandeladrawing/view/authview/login.dart';

import '../../subscription_screen.dart';

class SettingsScreen extends StatelessWidget {
  void _signOut() {
    FirebaseAuth.instance.signOut();
    Get.to(() => LoginPage());
  } //print('$user');

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      "Get unlimited access to all pictures and remove adds"),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubscriptionScreen()));
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  leading: IconButton(
                    onPressed: () {

                     // final FirebaseAuth auth = FirebaseAuth.instance;
                      // signOut() async {
                      //   print('object');
                      //   await auth.signOut();
                       
                      // }
                    },
                    icon: Icon(Icons.logout_rounded),
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: ()async{
            await  FirebaseAuth.instance.signOut();
               Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));

            }, child: Text("log out"))
          ],
        ),
      ),
    );
  }
}
