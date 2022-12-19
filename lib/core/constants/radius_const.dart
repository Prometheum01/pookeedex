import 'package:flutter/material.dart';

class RadiusConst extends BorderRadius {
  const RadiusConst.allSmall() : super.all(const Radius.circular(8));
  const RadiusConst.allBig() : super.all(const Radius.circular(36));
  const RadiusConst.all360() : super.all(const Radius.circular(360));
}
