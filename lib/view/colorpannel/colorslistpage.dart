import 'package:flutter/material.dart';

import '../../models/colorpalletemodel.dart';
import '../../utils/mycolors.dart';

class ColorslistPage extends StatefulWidget {
  const ColorslistPage({super.key});

  @override
  State<ColorslistPage> createState() => _ColorslistPageState();
}

class _ColorslistPageState extends State<ColorslistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            child: ListView.builder(
                itemCount: palletes.length,
                itemBuilder: (context, index) {
                  return PalleteWidget(
                    pallete: palletes[index],
                  );
                }),
          )
        ],
      ),
    );
  }
}

class PalleteWidget extends StatelessWidget {
  final MyColorPallet pallete;

  const PalleteWidget({super.key, required this.pallete});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(child: Text(pallete.pallete_nme)),
        Container(
          height: 300,
          child: ListView.builder(
            itemCount: pallete.mycolors.length,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                width: double.infinity,
                color: pallete.mycolors[index],
              );
            },
          ),
        )
      ],
    );
  }
}
