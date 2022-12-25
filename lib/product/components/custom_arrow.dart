import 'package:flutter/material.dart';

import '../../core/constants/radius_const.dart';

class CreateArrow extends StatelessWidget {
  const CreateArrow({
    Key? key,
    required this.height,
    required this.color,
  }) : super(key: key);

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _halfArrow(45),
        _halfArrow(-45),
      ],
    );
  }

  Transform _halfArrow(double angle) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const RadiusConst.allBig(),
        ),
        height: height,
        width: height * 2,
      ),
    );
  }
}
