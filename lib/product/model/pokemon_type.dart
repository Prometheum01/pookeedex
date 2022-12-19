import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part "pokemon_type.g.dart";

@HiveType(typeId: 9)
class PokemonType extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String url;

  const PokemonType({
    required this.name,
    required this.url,
  });

  static PokemonType get emptyType => const PokemonType(name: "Null", url: "");

  static PokemonType fromJson(Map<String, dynamic> json) {
    return PokemonType(
      name: json["type"]["name"].toString(),
      url: json["type"]["url"].toString(),
    );
  }

  @override
  List<Object?> props() => [name, url];
}
