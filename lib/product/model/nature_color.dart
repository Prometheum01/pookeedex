import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'nature_color.g.dart';

@HiveType(typeId: 7)
class NatureColor extends Equatable {
  @HiveField(0)
  final Color firstColor;

  @HiveField(1)
  final Color secondColor;

  @HiveField(2)
  final Color shadowColor;

  const NatureColor({
    required this.firstColor,
    required this.secondColor,
    required this.shadowColor,
  });

  @override
  List<Object?> props() => [firstColor, secondColor, shadowColor];
}
