// import 'package:flutter/material.dart';

// // class MyColorPallet {
// //   final String pallete_nme;
// //   final List<Color> mycolors;

// //   MyColorPallet(this.pallete_nme, this.mycolors);
// // }

// // List palletes = [
// //   MyColorPallet('Rainbow', [Colors.red, Colors.green, Colors.blue])
// //];
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ColorList {
//   final String title;
//   final List<Color> colors;

//   ColorList({required this.title, required this.colors});

//   // Convert model to Firestore document
//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'colors': colors,
//     };
//   }

//   // Create model from Firestore document
//   factory ColorList.fromSnapshot(DocumentSnapshot snapshot) {
//     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//     return ColorList(
//       title: data['title'],
//       colors: List<Color>.from(data['colors']),
//     );
//   }
// }
