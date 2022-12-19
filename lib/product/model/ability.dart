import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'ability.g.dart';

@HiveType(typeId: 0)
class Ability extends Equatable {
  @HiveField(0)
  final int slot;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String url;

  const Ability({
    required this.slot,
    required this.name,
    required this.url,
  });

  static Ability fromJson(Map<String, dynamic> json) {
    return Ability(
      slot: int.parse(json["slot"].toString()),
      name: json["ability"]["name"].toString(),
      url: json["ability"]["url"].toString(),
    );
  }

  @override
  List<Object?> props() => [slot, name, url];
}
