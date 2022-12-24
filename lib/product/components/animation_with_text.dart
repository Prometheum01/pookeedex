import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationWithText extends StatelessWidget {
  const AnimationWithText(
      {Key? key,
      required this.text,
      required this.animationPath,
      this.mainAxisAlignment = MainAxisAlignment.center})
      : super(key: key);

  final String text;
  final String animationPath;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Lottie.asset(animationPath),
        SizedBox(
          width: double.infinity,
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
