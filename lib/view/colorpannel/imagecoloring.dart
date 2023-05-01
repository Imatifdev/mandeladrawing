// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/mycolors.dart';

class ImageColoring extends StatelessWidget {
  const ImageColoring({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appbg,
      body: Column(
        children: [
          SizedBox(
            height: height / 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  onTap:
                  () => Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.left_chevron,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  onTap:
                  () => Navigator.pop(context);
                },
                icon: Icon(
                  Icons.undo,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  onTap:
                  () => Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.check_mark_circled,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  onTap:
                  () => Navigator.pop(context);
                },
                icon: Icon(
                  Icons.redo,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  onTap:
                  () => Navigator.pop(context);
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 30,
                ),
              )
            ],
          ),
          Container(
              //  height: MediaQuery.s,
              )
        ],
      ),
    );
  }
}
