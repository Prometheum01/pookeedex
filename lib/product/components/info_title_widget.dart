import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class InfoTitleWidget extends StatelessWidget {
  const InfoTitleWidget({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  final Color color;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.headline5?.copyWith(
        color: color,
      ),
    );
  }
}
