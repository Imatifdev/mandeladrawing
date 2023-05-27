// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mandeladrawing/models/colorpalletemodel.dart';
import 'package:mandeladrawing/models/sketch.dart';
import 'package:mandeladrawing/models/sketchmodel.dart';
import 'package:mandeladrawing/my.dart';
import 'package:mandeladrawing/view/colorpannel/detailmandela.dart';
import 'package:mandeladrawing/view/library/coloringlibrary.dart';
import 'package:mandeladrawing/view/settings/settingsscreen.dart';
import 'package:mandeladrawing/utils/mycolors.dart';
import 'package:mandeladrawing/view/colorpannel/animal.dart';

import '../colorpannel/viewmandelas.dart';
import '../createpannel/drawpage.dart';
import '../profile/profileview.dart';

class MyLibrary extends StatefulWidget {
  final List<String> selectedImages;

  MyLibrary({super.key, required this.selectedImages});

  @override
  State<MyLibrary> createState() => _MyLibraryState();
}

class _MyLibraryState extends State<MyLibrary> {
  int pgindex = 0;

  void selindex(int index) {
    setState(() {});
    pgindex = index;
  }

  final List<Widget> pages = [
    ViewMandelas(),
    DrawingPage(),
    MyLibrary(
      selectedImages: [],
    ),
    ProfileView(),
  ];

  List<int> listofpages = [];

  @override
  Widget build(BuildContext context) {
    if (check == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
      check++;
    }
    return Scaffold(
      backgroundColor: appbg,
      appBar: AppBar(
        title: Text(
          "Library",
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => SettingsScreen());
              },
              child: Icon(
                Icons.settings,
                size: 30,
                color: Colors.black,
              ),
            ),
          )
        ],
        backgroundColor: appbg,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1 / 13,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gd2, gd1],
              ),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Get All Pictures!",
                    style: TextStyle(
                        color: appbg,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Try Premium",
                    style: TextStyle(
                        color: appbg,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Purchased Mandelas",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PurchasedMandelas(
                                        selectedImages: widget.selectedImages,
                                      )));
                        },
                        child: Text(
                          "View More...",
                          style: TextStyle(
                              fontSize: 18,
                              color: gd2,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 1 / 5,
                  child: ListView.builder(
                      itemCount: widget.selectedImages.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(widget.selectedImages[index]));
                      }),
                ),
              ]),
            ]),
          ),
          //Expanded(child: pages[pgindex])
        ],
      ),
    );
  }
}

class PurchasedMandelas extends StatelessWidget {
  final List<dynamic> selectedImages;

  const PurchasedMandelas({
    super.key,
    required this.selectedImages,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Purchased Mandelas",
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => SettingsScreen());
              },
              child: Icon(
                Icons.settings,
                size: 30,
                color: Colors.black,
              ),
            ),
          )
        ],
        backgroundColor: appbg,
        elevation: 0,
      ),
      backgroundColor: appbg,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1 / 13,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gd2, gd1],
              ),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Get All Pictures!",
                    style: TextStyle(
                        color: appbg,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Try Premium",
                    style: TextStyle(
                        color: appbg,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 30,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                  itemCount: selectedImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DrawingBoard(
                                          sketch: SketchModel(
                                              selectedImages[index]),
                                          colorPallet:
                                              MyColorPallet("example", [
                                            Colors.pink.value,
                                            Colors.black87.value,
                                            Colors.yellow.value,
                                            Colors.red.value,
                                            Colors.amberAccent.value,
                                            Colors.purple.value,
                                            Colors.green.value,
                                            Colors.red.value,
                                            Colors.amberAccent.value,
                                            Colors.purple.value,
                                            Colors.green.value,
                                          ]),
                                        )),
                              );
                            },
                            child: Image.asset(selectedImages[index])));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
