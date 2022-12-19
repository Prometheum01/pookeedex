import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "assets/animation/loading.json",
      height: context.dynamicHeight(0.1),
      width: context.dynamicHeight(0.1),
    );
  }
}
