import 'package:flutter/material.dart';

class MyColorPallet {
  final String pallete_nme;
  final List<Color> mycolors;

  MyColorPallet(this.pallete_nme, this.mycolors);
}

List palletes = [
  MyColorPallet('Rainbow', [Colors.red, Colors.green, Colors.blue])
];
