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

class DetailMandela extends StatelessWidget {
  final SketchModel sketch;

  const DetailMandela({super.key, required this.sketch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(sketch.url))),
          )
        ],
      ),
    );
  }
}
