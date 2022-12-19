import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:pookeedex/core/extensions/string_extension.dart';

part 'evolve.g.dart';

@HiveType(typeId: 4)
// ignore: must_be_immutable
class Evolve extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final Evolve? evolvesTo;

  @HiveField(2)
  int? evolveLevel;

  @HiveField(3)
  final String image;

  Evolve({
    required this.name,
    required this.evolvesTo,
    required this.image,
    this.evolveLevel,
  });

  List<Evolve> get evolves {
    List<Evolve> evolveList = [];
    getEvolve(this, evolveList);
    return evolveList;
  }

  getEvolve(Evolve? evolve, evolves) {
    if (evolve!.evolvesTo != null) {
      evolves.add(evolve);
      getEvolve(evolve.evolvesTo, evolves);
    }
  }

  static get emptyEvolve =>
      Evolve(name: "Null", evolvesTo: null, image: "Null");

  static Evolve fromJson(Map<String, dynamic> json) {
    String? getLevel(Map<String, dynamic> json) {
      List list = json["evolution_details"];

      if (list.isNotEmpty) {
        return list.first["min_level"].toString();
      }
      return null;
    }

    String imageForBuild(String url) =>
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${url.toString().pookeeId}.png";

    Evolve? getEvolvesTo(Map<String, dynamic> json) {
      List list = json["evolves_to"];

      //https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png

      if (list.isNotEmpty) {
        for (var j in json["evolves_to"]) {
          return Evolve(
              name: j["species"]["name"].toString(),
              evolvesTo: getEvolvesTo(j),
              evolveLevel: int.tryParse(getLevel(j) ?? "-1"),
              image: imageForBuild(j["species"]["url"].toString()));
        }
      }
      return null;
    }

    return Evolve(
      name: json["species"]["name"].toString(),
      evolvesTo: getEvolvesTo(json),
      evolveLevel: int.tryParse(getLevel(json) ?? "-1"),
      image: imageForBuild(json["species"]["url"].toString()),
    );
  }

  @override
  List<Object?> props() => [name, evolvesTo, evolveLevel, image];
}
