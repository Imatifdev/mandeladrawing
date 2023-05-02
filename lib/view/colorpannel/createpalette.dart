import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mandeladrawing/widgets/drawcanvas.dart';

import '../../widgets/colorpallete.dart';

class CreateColorPallete extends HookWidget {
  final ValueNotifier<Color> selectedColor;

  CreateColorPallete(this.selectedColor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // DrawingCanvas(height: 200, width: 300, selectedColor: selectedColor, strokeSize: strokeSize, eraserSize: eraserSize, drawingMode: drawingMode, sideBarController: sideBarController, currentSketch: currentSketch, allSketches: allSketches, canvasGlobalKey: canvasGlobalKey, filled: filled, polygonSides: polygonSides, backgroundImage: backgroundImage)
        ],
      ),
    );
  }
}
