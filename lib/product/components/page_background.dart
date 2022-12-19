import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../core/constants/radius_const.dart';

class PageBackground extends StatelessWidget {
  const PageBackground({
    super.key,
    required this.height,
    required this.backgroundPaddingFromTop,
    required this.childPaddingFromTop,
    required this.child,
    this.horizontalPadding,
  });

  final double height;
  final double backgroundPaddingFromTop, childPaddingFromTop;
  final Widget child;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: backgroundPaddingFromTop,
            ),
            child: const _Background(),
          ),
          Positioned(
            top: childPaddingFromTop,
            left: horizontalPadding ?? context.dynamicWidth(0.05),
            right: horizontalPadding ?? context.dynamicWidth(0.05),
            child: child,
          )
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: RadiusConst.allBig(),
      ),
    );
  }
}
