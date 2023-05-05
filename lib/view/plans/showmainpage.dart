import 'package:flutter/material.dart';

class ShowingMainPage extends StatelessWidget {
  const ShowingMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Image(image: AssetImage('assets/i'))],
      ),
    );
  }
}
