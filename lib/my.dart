import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ColorPickerScreen extends StatefulWidget {
  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  List<Color> _colors = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _addColor(Color color) {
    if (_colors.length < 8) {
      setState(() {
        _colors.add(color);
      });
    }
  }

  void _saveColors() async {
    for (int i = 0; i < _colors.length; i++) {
      await _firestore.collection('colors').add({
        'color': _colors[i].value.toString(),
        'order': i,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Picker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: _colors.length,
              itemBuilder: (context, index) {
                return Container(
                  color: _colors[index],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Pick a color'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: Colors.red,
                              onColorChanged: (color) {
                                _addColor(color);
                              },
                              showLabel: true,
                              pickerAreaHeightPercent: 0.8,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Add color'),
                ),
                ElevatedButton(
                  onPressed: _colors.isNotEmpty ? _saveColors : null,
                  child: Text('Save colors'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
