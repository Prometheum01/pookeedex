import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:pookeedex/product/model/pokemon_type.dart';

part "move.g.dart";

@HiveType(typeId: 6)
class Move extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final PokemonType type;
  @HiveField(2)
  final String effectEntries;
  @HiveField(3)
  final String accuracy;
  @HiveField(4)
  final String basePower;
  @HiveField(5)
  final String pp;

  const Move({
    required this.name,
    required this.type,
    required this.effectEntries,
    required this.accuracy,
    required this.basePower,
    required this.pp,
  });

  String get normalName => name.replaceAll('-', ' ');

  static Move get emptyMove => Move(
      name: "Null",
      type: PokemonType.emptyType,
      effectEntries: "Null",
      accuracy: "Null",
      basePower: "Null",
      pp: "Null");

  static fromJson(Map<String, dynamic> json) {
    List effectList = json["effect_entries"];
    return Move(
      name: json["name"].toString(),
      type: PokemonType.fromJson(json),
      effectEntries: effectList.isNotEmpty
          ? effectList.first["effect"].toString()
          : "Null",
      accuracy: json["accuracy"].toString(),
      basePower: json["power"].toString(),
      pp: json["pp"].toString(),
    );
  }

  @override
  List<Object?> props() => [name, type, effectEntries, accuracy, basePower, pp];
}
