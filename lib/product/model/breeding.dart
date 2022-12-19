import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'egg_group.dart';

part 'breeding.g.dart';

@HiveType(typeId: 1)
class Breeding extends Equatable {
  @HiveField(0)
  final List<EggGroup> eggGroups;

  @HiveField(1)
  final int hatchCounter;

  @HiveField(2)
  final double genderRate;

  const Breeding({
    required this.eggGroups,
    required this.hatchCounter,
    required this.genderRate,
  });

  static get emptyBreeding => const Breeding(
        eggGroups: [],
        hatchCounter: -1,
        genderRate: -1,
      );

  static Breeding fromJson(Map<String, dynamic> json) {
    List<EggGroup> getEggGroups() {
      List<EggGroup> eggGroups = [];

      for (var j in json["egg_groups"]) {
        eggGroups.add(EggGroup.fromJson(j));
      }
      return eggGroups;
    }

    return Breeding(
      eggGroups: getEggGroups(),
      hatchCounter: int.parse(json["hatch_counter"].toString()),
      genderRate: double.parse(json["gender_rate"].toString()),
    );
  }

  @override
  List<Object?> props() => [eggGroups, hatchCounter, genderRate];
}
