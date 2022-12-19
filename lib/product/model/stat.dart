import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'stat.g.dart';

@HiveType(typeId: 11)
class Stat extends Equatable {
  @HiveField(0)
  final int baseStats;

  @HiveField(1)
  final int effort;

  @HiveField(2)
  final String name;

  const Stat({
    required this.baseStats,
    required this.effort,
    required this.name,
  });

  static Stat fromJson(Map<String, dynamic> json) {
    return Stat(
      baseStats: int.parse(json["base_stat"].toString()),
      effort: int.parse(json["effort"].toString()),
      name: json["stat"]["name"].toString(),
    );
  }

  @override
  List<Object?> props() => [baseStats, effort, name];
}
