import 'package:flutter/material.dart';

class MainGradient extends StatelessWidget {
  const MainGradient({
    Key? key,
    this.height,
  }) : super(key: key);

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF6E95FD),
            Color(0xFF6FDEFA),
            Color(0xFF8DE061),
            Color(0xFF51E85E),
          ],
        ),
      ),
    );
  }
}
