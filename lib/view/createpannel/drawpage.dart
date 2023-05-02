// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:mandeladrawing/widgets/drawcanvas.dart';

import '../../models/drawingmode.dart';
import '../../models/sketch.dart';
import '../../models/sketchmodel.dart';
import '../../utils/mycolors.dart';
import '../../widgets/create.dart';
import '../settings/settingsscreen.dart';
import 'package:path/path.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

// class DrawingPage extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     final sliderValue = useState(200.0);
//     void updateSlider(double value) {
//       sliderValue.value = value;
//     }

//     final selectedColor = useState(Colors.black);
//     final strokeSize = useState<double>(10);
//     final eraserSize = useState<double>(30);
//     final drawingMode = useState(DrawingMode.pencil);
//     final filled = useState<bool>(false);
//     final polygonSides = useState<int>(3);
//     final backgroundImage = useState<Image?>(null);

//     final canvasGlobalKey = GlobalKey();

//     ValueNotifier<Sketch?> currentSketch = useState(null);
//     ValueNotifier<List<Sketch>> allSketches = useState([]);

//     final animationController = useAnimationController(
//       duration: const Duration(milliseconds: 150),
//       initialValue: 1,
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Animal Mandela",
//           style: TextStyle(fontSize: 30, color: Colors.black),
//         ),
//         toolbarHeight: MediaQuery.of(context).size.height * 1 / 10,
//         leading: GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: Icon(
//             Icons.turn_left,
//             color: Colors.black,
//             size: 30,
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: GestureDetector(
//               onTap: () {
//                 Get.to(() => SettingsScreen());
//               },
//               child: Icon(
//                 Icons.settings,
//                 size: 30,
//                 color: Colors.black,
//               ),
//             ),
//           )
//         ],
//         backgroundColor: appbg,
//         elevation: 0,
//       ),
//       backgroundColor: kCanvasColor,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 1 / 13,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: const [gd2, gd1],
//               ),
//             ),
//             width: double.infinity,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     "Get All Pictures!",
//                     style: TextStyle(
//                         color: appbg,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     "Try Premium",
//                     style: TextStyle(
//                         color: appbg,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 //color: Colors.red,

//                 //    image: DecorationImage(image: AssetImage(skecthpic.url))),
//                 ),
//             width: MediaQuery.of(context).size.width - 30,
//             height: MediaQuery.of(context).size.height / 2.6,
//             child: Center(
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: kCanvasColor,
//                     border: Border.all(color: Colors.grey.shade200, width: 1)),
//                 width: sliderValue.value,
//                 height: sliderValue.value,
//                 child: DrawingCanvas(
//                   width: 300,
//                   height: 300,

//                   // width: MediaQuery.of(context).size.width,
//                   // height: MediaQuery.of(context).size.height,
//                   drawingMode: drawingMode,
//                   selectedColor: selectedColor,
//                   strokeSize: strokeSize,
//                   eraserSize: eraserSize,
//                   sideBarController: animationController,
//                   currentSketch: currentSketch,
//                   allSketches: allSketches,
//                   canvasGlobalKey: canvasGlobalKey,
//                   filled: filled,
//                   polygonSides: polygonSides,
//                   backgroundImage: backgroundImage,
//                 ),
//               ),

//               // Positioned(
//               //   top: kToolbarHeight + 10,
//               //   // left: -5,
//               //   child: SlideTransition(
//               //     position: Tween<Offset>(
//               //       begin: const Offset(-1, 0),
//               //       end: Offset.zero,
//               //     ).animate(animationController),
//               //     child: CanvasSideBar(
//               //       drawingMode: drawingMode,
//               //       selectedColor: selectedColor,
//               //       strokeSize: strokeSize,
//               //       eraserSize: eraserSize,
//               //       currentSketch: currentSketch,
//               //       allSketches: allSketches,
//               //       canvasGlobalKey: canvasGlobalKey,
//               //       filled: filled,
//               //       polygonSides: polygonSides,
//               //       backgroundImage: backgroundImage,
//               //     ),
//               //   ),
//               // ),
//               // _CustomAppBar(animationController: animationController),
//             ),
//           ),
//           Container(
//             color: Colors.white,
//             height: 150,
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Container(
//                     color: Colors.transparent,
//                     height: 50,
//                     child: Slider(
//                       label: sliderValue.toString(),
//                       value: sliderValue.value,
//                       min: 200,
//                       max: 1000,
//                       onChanged: updateSlider,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: MyDrawing(
//                       selectedColor: selectedColor,
//                       strokeSize: strokeSize,
//                       eraserSize: eraserSize,
//                       drawingMode: drawingMode,
//                       currentSketch: currentSketch,
//                       allSketches: allSketches,
//                       canvasGlobalKey: canvasGlobalKey,
//                       filled: filled,
//                       polygonSides: polygonSides,
//                       backgroundImage: backgroundImage),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
class DrawingRoomScreen extends StatefulWidget {
  const DrawingRoomScreen({super.key});

  @override
  State<DrawingRoomScreen> createState() => _DrawingRoomScreenState();
}

class _DrawingRoomScreenState extends State<DrawingRoomScreen> {
  var avaiableColor = [
    Colors.black,
    Colors.red,
    Colors.amber,
    Colors.blue,
    Colors.green,
    Colors.brown,
  ];

  var historyDrawingPoints = <DrawingPoint>[];
  var drawingPoints = <DrawingPoint>[];

  var selectedColor = Colors.black;
  var selectedWidth = 2.0;

  DrawingPoint? currentDrawingPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Canvas
          GestureDetector(
            onPanStart: (details) {
              setState(() {
                currentDrawingPoint = DrawingPoint(
                  id: DateTime.now().microsecondsSinceEpoch,
                  offsets: [
                    details.localPosition,
                  ],
                  color: selectedColor,
                  width: selectedWidth,
                );

                if (currentDrawingPoint == null) return;
                drawingPoints.add(currentDrawingPoint!);
                historyDrawingPoints = List.of(drawingPoints);
              });
            },
            onPanUpdate: (details) {
              setState(() {
                if (currentDrawingPoint == null) return;

                currentDrawingPoint = currentDrawingPoint?.copyWith(
                  offsets: currentDrawingPoint!.offsets
                    ..add(details.localPosition),
                );
                drawingPoints.last = currentDrawingPoint!;
                historyDrawingPoints = List.of(drawingPoints);
              });
            },
            onPanEnd: (_) {
              currentDrawingPoint = null;
            },
            child: SizedBox(
              height: 300,
              width: 300,
              child: CustomPaint(
                size: Size(300, 300),
                painter: DrawingPainter(
                  drawingPoints: drawingPoints,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
          ),

          /// color pallet
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 16,
            right: 16,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: avaiableColor.length,
                separatorBuilder: (_, __) {
                  return const SizedBox(width: 8);
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = avaiableColor[index];
                      });
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: avaiableColor[index],
                        shape: BoxShape.circle,
                      ),
                      foregroundDecoration: BoxDecoration(
                        border: selectedColor == avaiableColor[index]
                            ? Border.all(color: Colors.red, width: 4)
                            : null,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          /// pencil size
          Positioned(
            top: MediaQuery.of(context).padding.top + 80,
            right: 0,
            bottom: 150,
            child: RotatedBox(
              quarterTurns: 3, // 270 degree
              child: Slider(
                value: selectedWidth,
                min: 1,
                max: 20,
                onChanged: (value) {
                  setState(() {
                    selectedWidth = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "Undo",
            onPressed: () {
              if (drawingPoints.isNotEmpty && historyDrawingPoints.isNotEmpty) {
                setState(() {
                  drawingPoints.removeLast();
                });
              }
            },
            child: const Icon(Icons.undo),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: "Redo",
            onPressed: () {
              setState(() {
                if (drawingPoints.length < historyDrawingPoints.length) {
                  // 6 length 7
                  final index = drawingPoints.length;
                  drawingPoints.add(historyDrawingPoints[index]);
                }
              });
            },
            child: const Icon(Icons.redo),
          ),
        ],
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint> drawingPoints;

  DrawingPainter({required this.drawingPoints});

  @override
  void paint(Canvas canvas, Size size) {
    for (var drawingPoint in drawingPoints) {
      final paint = Paint()
        ..color = drawingPoint.color
        ..isAntiAlias = true
        ..strokeWidth = drawingPoint.width
        ..strokeCap = StrokeCap.round;

      for (var i = 0; i < drawingPoint.offsets.length; i++) {
        var notLastOffset = i != drawingPoint.offsets.length - 1;

        if (notLastOffset) {
          final current = drawingPoint.offsets[i];
          final next = drawingPoint.offsets[i + 1];
          canvas.drawLine(current, next, paint);
        } else {
          /// we do nothing
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DrawingPoint {
  int id;
  List<Offset> offsets;
  Color color;
  double width;

  DrawingPoint({
    this.id = -1,
    this.offsets = const [],
    this.color = Colors.black,
    this.width = 2,
  });

  DrawingPoint copyWith({List<Offset>? offsets}) {
    return DrawingPoint(
      id: id,
      color: color,
      width: width,
      offsets: offsets ?? this.offsets,
    );
  }
}
