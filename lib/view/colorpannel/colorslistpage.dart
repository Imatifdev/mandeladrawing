// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mandeladrawing/view/colorpannel/detailmandela.dart';

class ColorListPage extends StatelessWidget {
  final String palletName = "Rainbow";

  TextEditingController name = TextEditingController();
  List<Color> colors = [
    Colors.black,
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.limeAccent,
    Colors.pink,
    Colors.yellow,
    Colors.indigo
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: colors[index],
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Enter your pallete name",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),

                  borderRadius:
                      BorderRadius.circular(20), // Set border radius here
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),

                  borderRadius:
                      BorderRadius.circular(20), // Set border radius here
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius:
                      BorderRadius.circular(20), // Set border radius here
                ),
                filled: true,
                fillColor: const Color(0xffeceff6),
                contentPadding: const EdgeInsets.all(8),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "palletName",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    //  color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  width: double.infinity,
                  height: 350,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: colors.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        width: 150,
                        color: colors[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
