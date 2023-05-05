// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mandeladrawing/widgets/canvassidedar.dart';
import 'package:mandeladrawing/widgets/drawcanvas.dart';

import '../../models/colorpalletemodel.dart';
import '../../models/drawingmode.dart';
import '../../models/sketch.dart';
import '../../models/sketchmodel.dart';
import '../../utils/mycolors.dart';
import '../../widgets/create.dart';
import '../settings/settingsscreen.dart';
import 'imagetexture.dart';

class DetailMandela extends HookWidget {
  final SketchModel sketch;

  DetailMandela({super.key, required this.sketch});
  final List<String> backgrounds = [
    'assets/textures/2.png',
    'assets/textures/3.png',
    'assets/textures/4.png',
    'assets/textures/5.png',
    'assets/textures/6.png',
  ];
  @override
  Widget build(BuildContext context) {
    // String selectedBackground = 'assets/textures/6.png';

    final selectedBackgroundState = useState(0);

    final selectedBackground = backgrounds[selectedBackgroundState.value];
    // final value = useState(false);

    final selectedColor = useState(Colors.black);
    final strokeSize = useState<double>(10);
    final eraserSize = useState<double>(30);
    final drawingMode = useState(DrawingMode.pencil);
    final filled = useState<bool>(false);
    final polygonSides = useState<int>(3);
    final backgroundImage = useState<Image?>(null);
    final showList = useState<bool>(true);

    final canvasGlobalKey = GlobalKey();
    ValueNotifier<Sketch?> currentSketch = useState(null);
    ValueNotifier<List<Sketch>> allSketches = useState([]);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 150),
      initialValue: 1,
    );

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: appbg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: height / 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.turn_left,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.undo,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ImageTexture()));
                      // _isvisible.value = true;
                      //_isvisible.value = false;
                      showList.value = !showList.value;
                    },
                    icon: Icon(
                      Icons.check_circle_outline,
                      color: Colors.black,
                      size: 30,
                    )),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.redo,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 30,
                ),
              )
            ],
          ),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(selectedBackground),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                height: height / 1.8,
                width: width,
              ),
              Center(
                child: Container(
                  height: height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(sketch.url),
                    ),
                  ),
                  //  child: DrawingCanvas(),
                ),
              ),
              DrawingCanvas(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
            ],
          ),
          // ignore: unrelated_type_equality_checks
          // _isvisible.value?
          showList.value
              ? CanvasSideBar(
                  selectedColor: selectedColor,
                  strokeSize: strokeSize,
                  eraserSize: eraserSize,
                  drawingMode: drawingMode,
                  currentSketch: currentSketch,
                  allSketches: allSketches,
                  canvasGlobalKey: canvasGlobalKey,
                  filled: filled,
                  polygonSides: polygonSides,
                  backgroundImage: backgroundImage)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Textures",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: backgrounds.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () =>
                                    selectedBackgroundState.value = index,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(backgrounds[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  width: 100,
                                  height: 100,
                                ),
                              );
                            })),
                  ],
                ),
        ],
      ),
    );
  }
}
