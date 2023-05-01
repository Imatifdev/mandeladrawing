// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:mandeladrawing/widgets/drawcanvas.dart';

import '../../models/drawingmode.dart';
import '../../models/sketch.dart';
import '../../utils/mycolors.dart';
import '../../widgets/create.dart';
import '../settings/settingsscreen.dart';

class DrawingPage extends HookWidget {
  const DrawingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sliderValue = useState(200.0);
    void _updateSlider(double value) {
      _sliderValue.value = value;
    }

    final selectedColor = useState(Colors.black);
    final strokeSize = useState<double>(10);
    final eraserSize = useState<double>(30);
    final drawingMode = useState(DrawingMode.pencil);
    final filled = useState<bool>(false);
    final polygonSides = useState<int>(3);
    final backgroundImage = useState<Image?>(null);

    final canvasGlobalKey = GlobalKey();

    ValueNotifier<Sketch?> currentSketch = useState(null);
    ValueNotifier<List<Sketch>> allSketches = useState([]);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 150),
      initialValue: 1,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Animal Mandela",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 1 / 10,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.turn_left,
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
      backgroundColor: kCanvasColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1 / 13,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [gd2, gd1],
              ),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
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
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              height: MediaQuery.of(context).size.height / 2.6,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: kCanvasColor,
                          border: Border.all(
                              color: Colors.grey.shade200, width: 1)),
                      width: _sliderValue.value,
                      height: _sliderValue.value,
                      child: DrawingCanvas(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,

                        // width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height,
                        drawingMode: drawingMode,
                        selectedColor: selectedColor,
                        strokeSize: strokeSize,
                        eraserSize: eraserSize,
                        sideBarController: animationController,
                        currentSketch: currentSketch,
                        allSketches: allSketches,
                        canvasGlobalKey: canvasGlobalKey,
                        filled: filled,
                        polygonSides: polygonSides,
                        backgroundImage: backgroundImage,
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: kToolbarHeight + 10,
                  //   // left: -5,
                  //   child: SlideTransition(
                  //     position: Tween<Offset>(
                  //       begin: const Offset(-1, 0),
                  //       end: Offset.zero,
                  //     ).animate(animationController),
                  //     child: CanvasSideBar(
                  //       drawingMode: drawingMode,
                  //       selectedColor: selectedColor,
                  //       strokeSize: strokeSize,
                  //       eraserSize: eraserSize,
                  //       currentSketch: currentSketch,
                  //       allSketches: allSketches,
                  //       canvasGlobalKey: canvasGlobalKey,
                  //       filled: filled,
                  //       polygonSides: polygonSides,
                  //       backgroundImage: backgroundImage,
                  //     ),
                  //   ),
                  // ),
                  // _CustomAppBar(animationController: animationController),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: 150,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    height: 50,
                    child: Slider(
                      label: _sliderValue.toString(),
                      value: _sliderValue.value,
                      min: 200,
                      max: 1000,
                      onChanged: _updateSlider,
                    ),
                  ),
                ),
                Expanded(
                  child: MyDrawing(
                      selectedColor: selectedColor,
                      strokeSize: strokeSize,
                      eraserSize: eraserSize,
                      drawingMode: drawingMode,
                      currentSketch: currentSketch,
                      allSketches: allSketches,
                      canvasGlobalKey: canvasGlobalKey,
                      filled: filled,
                      polygonSides: polygonSides,
                      backgroundImage: backgroundImage),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
