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

  const DetailMandela({super.key, required this.sketch});

  @override
  Widget build(BuildContext context) {
    // final sliderValue = useState(200.0);
    // void updateSlider(double value) {
    //   sliderValue.value = value;
    // }

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
    String _selectedBackground = 'assets/art/2.png';
    final List<String> _backgrounds = [
      'assets/art/3.png',
      'assets/art/4.png',
      'assets/art/5.png',
      'assets/art/6.png'
    ];
    bool check = true;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: height / 20,
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
                icon: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageTexture()));
                    },
                    icon: Icon(
                      Icons.check_circle_outline,
                      color: Colors.black,
                      size: 30,
                    )),
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
          SizedBox(
            height: height / 30,
          ),
          Stack(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(sketch.url),
                  ),
                ),
                //  child: DrawingCanvas(),
              ),
              DrawingCanvas(
                width: 300,
                height: 300,

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
            ],
          ),
          CanvasSideBar(
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
        ],
      ),
    );
  }
}
