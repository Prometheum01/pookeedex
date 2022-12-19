import 'package:flutter/material.dart';

class PaddingConst extends EdgeInsets {
  const PaddingConst.smallAll() : super.all(8);
  const PaddingConst.smallHorizontal() : super.symmetric(horizontal: 8);
  const PaddingConst.smallVertical() : super.symmetric(vertical: 8);
  const PaddingConst.mediumAll() : super.all(16);
  const PaddingConst.mediumHorizontal() : super.symmetric(horizontal: 16);
  const PaddingConst.mediumVertical() : super.symmetric(vertical: 16);
  const PaddingConst.largeAll() : super.all(24);
  const PaddingConst.largeVertical() : super.symmetric(vertical: 24);
}
