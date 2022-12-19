import 'package:equatable/equatable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

import 'nature_color.dart';

part 'nature.g.dart';

@HiveType(typeId: 8)
class Nature extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final NatureColor natureColor;

  @HiveField(2)
  final String iconPath;

  const Nature({
    required this.name,
    required this.natureColor,
    required this.iconPath,
  });

  SvgPicture get toSvg => SvgPicture.asset(
        iconPath,
        height: 24,
      );

  @override
  List<Object?> props() => [name, natureColor, iconPath];
}
