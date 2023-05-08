// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandeladrawing/models/sketchmodel.dart';
import 'package:mandeladrawing/view/library/mylibrary.dart';
import 'package:mandeladrawing/view/settings/settingsscreen.dart';
import 'package:mandeladrawing/utils/mycolors.dart';
import 'package:mandeladrawing/view/colorpannel/animal.dart';

class SelectMandelas extends StatefulWidget {
  final int package;

  const SelectMandelas({super.key, required this.package});

  @override
  State<SelectMandelas> createState() => _SelectMandelasState();
}

class _SelectMandelasState extends State<SelectMandelas> {
  List<String> _selectedImages = [];
  List<String> _imageList = [
    'assets/art/2.png',
    'assets/art/3.png',
    'assets/art/4.png',
    'assets/art/5.png',
    'assets/art/6.png',
    'assets/art/7.png',
    'assets/art/8.png',
    'assets/art/9.png',
    'assets/art/12.png',
    'assets/art/11.png',
    'assets/art/2.png',
    'assets/art/3.png',
    'assets/art/4.png',
    'assets/art/5.png',
    'assets/art/6.png',
    'assets/art/7.png',
    'assets/art/8.png',
    'assets/art/9.png',
    'assets/art/12.png',
    'assets/art/2.png',
    'assets/art/3.png',
    'assets/art/4.png',
    'assets/art/5.png',
    'assets/art/6.png',
    'assets/art/7.png',
    'assets/art/8.png',
    'assets/art/9.png',
    'assets/art/12.png',
  ];
  //int package;

  void _onImageSelected(String imageUrl) {
    setState(() {
      if (_selectedImages.contains(imageUrl)) {
        _selectedImages.remove(imageUrl);
      } else {
        if (_selectedImages.length < widget.package) {
          _selectedImages.add(imageUrl);
        } else {
          // Show an error message or other feedback to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You have reached the maximum number of images.'),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appbg,
      appBar: AppBar(
        title: Text(
          "Fill Color",
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All Mandelas",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => AnimalMandel());
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
                        itemCount: _imageList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                _onImageSelected(_imageList[index]);
                              },
                              child: Stack(
                                children: [
                                  Image.asset(_imageList[index]),
                                  if (_selectedImages
                                      .contains(_imageList[index]))
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                      ),
                                    ),
                                  if (!_selectedImages
                                      .contains(_imageList[index]))
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Icon(
                                        Icons.circle_outlined,
                                        color: Colors.red,
                                      ),
                                    ),
                                ],
                              ),
                              //  ShowGrid(
                              //   skectpic: UsersData.users[index],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ]),
          ),
          FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MyLibrary(selectedImages: _selectedImages),
                    ));
              },
              label: Text("Done"))
        ],
      ),
    );
  }
}

// class ShowGrid extends StatefulWidget {
//   final SketchModel skectpic;

//   const  ShowGrid({super.key, required this.skectpic});

//   @override
//   State<ShowGrid> createState() => _ShowGridState();
// }

// class _ShowGridState extends State<ShowGrid> {
// List<String> _selectedImages = [];
//   List<String> _imageList = [
//     'assets/art/2.png',
//     'assets/art/3.png',
//     'assets/art/4.png',
//     'assets/art/5.png',
//     'assets/art/6.png',
//     'assets/art/7.png',
//     'assets/art/8.png',
//     'assets/art/9.png',
//     'assets/art/12.png',
//     'assets/art/11.png'
//   ];
//   int _maxImages = 3;


//   void _onImageSelected(String imageUrl) {
//     setState(() {
//       if (_selectedImages.contains(imageUrl)) {
//         _selectedImages.remove(imageUrl);
//       } else {
//         if (_selectedImages.length < _maxImages) {
//           _selectedImages.add(imageUrl);
//         } else {
//           // Show an error message or other feedback to the user
//           Get.snackbar("Message","You have reached the maximum number of images.");
         
//         }
//       }
//     });
//   }

//   @override

//   Widget build(BuildContext context) {
//     return
//  GestureDetector(
//             onTap: () {
//               _onImageSelected(_imageLis);
//             },
//             child: Stack(
//               children: [
//                 Image.asset(_imageList[index]),
//                 if (_selectedImages.contains(_imageList[index]))
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Icon(
//                       Icons.check_circle,
//                       color: Colors.green,
//                     ),
//                   ),
//               ],
//             ),
//           );
//      //  Image(
//     //   fit: BoxFit.cover,
//     //   height: 200,
//     //   width: 200,
//     //   image: AssetImage(skectpic.url),
//     // );
//   }
// }
