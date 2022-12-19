import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class PookeImage extends StatelessWidget {
  const PookeImage({
    Key? key,
    required this.pookeeImage,
  }) : super(key: key);

  final String pookeeImage;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      pookeeImage,
      height: context.dynamicHeight(0.2),
    );
  }
}
