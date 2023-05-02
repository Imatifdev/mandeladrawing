import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class MultiColorPickerScreen extends StatefulWidget {
  @override
  _MultiColorPickerScreenState createState() => _MultiColorPickerScreenState();
}

class _MultiColorPickerScreenState extends State<MultiColorPickerScreen> {
  List<Color> _selectedColors = [];

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Color _currentColor = Colors.white;

        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (Color color) {
                setState(() {
                  _currentColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(_currentColor);
              },
            ),
          ],
        );
      },
    ).then((color) {
      if (color != null) {
        setState(() {
          _selectedColors.add(color);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Color Picker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _selectedColors.length,
              itemBuilder: (BuildContext context, int index) {
                final color = _selectedColors[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color,
                    radius: 20,
                  ),
                  title: Text('$color'),
                );
              },
            ),
          ),
          ElevatedButton(
            child: const Text('Add color'),
            onPressed: _showColorPicker,
          ),
        ],
      ),
    );
  }
}
