import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'egg_group.g.dart';

@HiveType(typeId: 3)
class EggGroup extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String url;

  const EggGroup({
    required this.name,
    required this.url,
  });

  static EggGroup fromJson(Map<String, dynamic> json) {
    return EggGroup(
      name: json["name"].toString(),
      url: json["url"].toString(),
    );
  }

  @override
  List<Object?> props() => [name, url];
}
