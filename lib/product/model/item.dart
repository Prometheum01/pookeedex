import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:pookeedex/core/extensions/string_extension.dart';

part 'item.g.dart';

@HiveType(typeId: 5)
// ignore: must_be_immutable
class Item extends Equatable {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String cost;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final int id;

  @HiveField(5)
  String? cacheImageToken;

  Item({
    required this.name,
    required this.cost,
    required this.image,
    required this.description,
    required this.id,
    this.cacheImageToken,
  });

  static Item fromJson(Map<String, dynamic> json) {
    List effectList = json["effect_entries"];
    return Item(
      name: json["name"].toString().fromJsonText,
      cost: json["cost"].toString(),
      image: json["sprites"]["default"].toString(),
      description: (json["effect_entries"] as List).isNotEmpty
          ? effectList.first["effect"].toString()
          : "Null",
      id: int.parse(json["id"].toString()),
    );
  }

  static Item get emptyItem =>
      Item(name: "Null", cost: "0", image: "", description: "Null", id: -1);

  @override
  List<Object?> props() => [
        name,
        cost,
        image,
        description,
        id,
      ];
}
