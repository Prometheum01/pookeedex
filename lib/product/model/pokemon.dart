import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pookeedex/product/model/move.dart';
import 'package:pookeedex/product/model/nature.dart';
import 'package:pookeedex/product/model/pokemon_type.dart';
import 'package:pookeedex/product/model/stat.dart';

import '../constants/nature_constants.dart';
import 'ability.dart';
import 'breeding.dart';
import 'capture.dart';
import 'evolve.dart';

part 'pokemon.g.dart';

@HiveType(typeId: 10)
// ignore: must_be_immutable
class Pokemon extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final List<Ability> abilities;

  @HiveField(4)
  final List<Stat> stats;

  @HiveField(5)
  final List<PokemonType> types;

  @HiveField(6)
  List<Move>? moves;

  @HiveField(7)
  final Breeding breeding;

  @HiveField(8)
  final Capture capture;

  @HiveField(9)
  final Evolve evolve;

  Pokemon({
    required this.id,
    required this.name,
    required this.image,
    required this.abilities,
    required this.stats,
    required this.types,
    required this.breeding,
    required this.capture,
    required this.evolve,
    this.moves,
  });

  static Pokemon fromJson({
    required Map<String, dynamic> pookeeJson,
    required Map<String, dynamic> speciesJson,
    required Map<String, dynamic> chainJson,
  }) {
    List<Ability> getAbilities() {
      List<Ability> abilities = [];

      for (var j in pookeeJson["abilities"]) {
        abilities.add(Ability.fromJson(j));
      }
      return abilities;
    }

    List<Stat> getStats() {
      List<Stat> stats = [];

      for (var j in pookeeJson["stats"]) {
        stats.add(Stat.fromJson(j));
      }
      return stats;
    }

    List<PokemonType> getTypes() {
      List<PokemonType> types = [];

      for (var j in pookeeJson["types"]) {
        types.add(PokemonType.fromJson(j));
      }
      return types;
    }

    return Pokemon(
      id: int.parse(pookeeJson["id"].toString()),
      name: pookeeJson["name"].toString(),
      image: pookeeJson["sprites"]["other"]["official-artwork"]["front_default"]
          .toString(),
      abilities: getAbilities(),
      stats: getStats(),
      types: getTypes(),
      breeding: Breeding.fromJson(speciesJson),
      capture: Capture.fromJson(speciesJson),
      evolve: Evolve.fromJson(chainJson["chain"]),
    );
  }

  changeMoves(List<Move>? newList) {
    moves = newList;
  }

  Color get mainFirstColor => natures.first.natureColor.firstColor;
  Color get mainSecondColor => natures.first.natureColor.secondColor;

  List<Nature> get natures {
    return types.map((e) => NatureConst.checkNatureWithName(e.name)).toList();
  }

  static Pokemon get emptyPokemon => Pokemon(
        id: -1,
        name: "Null",
        image: "",
        abilities: const [],
        stats: const [],
        types: const [],
        breeding: Breeding.emptyBreeding,
        capture: Capture.emptyCapture,
        evolve: Evolve.emptyEvolve,
      );

  @override
  List<Object?> props() =>
      [id, name, image, abilities, stats, types, breeding, capture, evolve];
}
