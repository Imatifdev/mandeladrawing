// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandeladrawing/models/colorpalletemodel.dart';
import 'package:mandeladrawing/models/sketch.dart';
import 'package:mandeladrawing/my.dart';
import 'package:mandeladrawing/utils/mycolors.dart';
import 'package:mandeladrawing/view/colorpannel/detailmandela.dart';

import '../../models/sketchmodel.dart';
import '../createpannel/drawpage.dart';
import '../library/coloringlibrary.dart';
import '../plans/showplans.dart';
import '../settings/settingsscreen.dart';

class AnimalMandel extends StatelessWidget {
  const AnimalMandel({super.key});

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
      fontSize = 15.0;
      title = 28;

      heading = 21; // Medium screen (e.g., iPhone 6, 7, 8)
    } else if (screenWidth < 414) {
      fontSize = 17.0;
      title = 32;

      heading = 25; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    } else if (screenWidth < 600) {
      fontSize = 19.0;
      title = 36;

      heading = 27; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    } else {
      fontSize = 22.0;
      title = 40;

      heading = 30; // Extra large screen or unknown device
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Animal Mandela...",
          style: TextStyle(fontSize: title, color: Colors.black),
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
            height: screenheight / 12,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gd2, gd1],
              ),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Plans()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Get All Pictures!",
                      style: TextStyle(
                          color: appbg,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Try Premium",
                      style: TextStyle(
                          color: appbg,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                  itemCount: 3,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final show = UsersData.users[index];
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DrawingBoard(
                                sketch: show,
                                colorPallet: MyColorPallet("Example", [
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
                              ),
                            ),
                          );
                        },
                        child: ShowGrid(sketchpic: show));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowGrid extends StatelessWidget {
  final SketchModel sketchpic;

  const ShowGrid({super.key, required this.sketchpic});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(
          fit: BoxFit.cover,
          height: 200,
          width: 200,
          image: AssetImage(sketchpic.url),
        ),
      ),
    );
  }
}
