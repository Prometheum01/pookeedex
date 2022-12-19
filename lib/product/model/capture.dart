import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'capture.g.dart';

@HiveType(typeId: 2)
class Capture extends Equatable {
  @HiveField(0)
  final String habitat;

  @HiveField(1)
  final String generation;

  @HiveField(2)
  final int captureRate;

  const Capture({
    required this.habitat,
    required this.generation,
    required this.captureRate,
  });

  static get emptyCapture => const Capture(
        habitat: "Null",
        generation: "Null",
        captureRate: -1,
      );

  static Capture fromJson(Map<String, dynamic> json) {
    return Capture(
      habitat: json["habitat"]["name"].toString(),
      generation: json["generation"]["name"].toString(),
      captureRate: int.parse(json["capture_rate"].toString()),
    );
  }

  @override
  List<Object?> props() => [habitat, generation, captureRate];
}
