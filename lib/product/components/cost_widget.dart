import 'package:flutter/material.dart';

import '../../core/constants/padding_const.dart';

class CostWidget extends StatelessWidget {
  const CostWidget({
    Key? key,
    required this.cost,
    required this.color,
    this.align = MainAxisAlignment.end,
  }) : super(key: key);

  final String cost;
  final Color color;
  final MainAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: align,
      children: [
        Padding(
          padding: const PaddingConst.smallHorizontal(),
          child: Text(cost),
        ),
        Container(
          height: 16,
          width: 8,
          color: color,
        ),
      ],
    );
  }
}
