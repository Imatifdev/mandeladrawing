import 'package:flutter/material.dart';

class ColorSlider extends StatefulWidget {
  final Color initialColor;

  const ColorSlider({Key? key, required this.initialColor}) : super(key: key);

  @override
  _ColorSliderState createState() => _ColorSliderState();
}

class _ColorSliderState extends State<ColorSlider> {
  Color _selectedColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    _selectedColor.withOpacity(1),
                  ],
                ),
              ),
            ),
          ),
        ),
        Slider(
          value: _selectedColor.opacity,
          onChanged: (newOpacity) {
            setState(() {
              _selectedColor = _selectedColor.withOpacity(newOpacity);
            });
          },
        ),
      ],
    );
  }
}
