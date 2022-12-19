import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/enum/hive.dart';
import '../../core/services/cache/hive_manager.dart';
import '../model/item.dart';
import '../model/pokemon.dart';

class PookeeCachedImage extends StatelessWidget {
  const PookeeCachedImage(
      {super.key, required this.pookee, required this.type});

  final Pokemon pookee;

  final HiveEnum type;

  @override
  Widget build(BuildContext context) {
    return HiveManager().checkDataInBox<Pokemon>(data: pookee, hiveEnum: type)
        ? Image.file(File(
            //TODO:Duzenle
            "/storage/emulated/0/Android/data/com.example.pookeedex/files/${HiveEnum.pokemon_images.name}/images/${pookee.id}.png"))
        : Image.network(
            pookee.image.toString(),
          );
  }
}

class ItemCachedImage extends StatelessWidget {
  const ItemCachedImage({super.key, required this.item, required this.type});

  final Item item;
  final HiveEnum type;

  @override
  Widget build(BuildContext context) {
    return HiveManager().checkDataInBox<Item>(data: item, hiveEnum: type)
        ? Image.file(
            File(
              //TODO:Duzenle
              "/storage/emulated/0/Android/data/com.example.pookeedex/files/${HiveEnum.item_images.name}/images/${item.id}.png",
            ),
            fit: BoxFit.cover,
          )
        : Image.network(
            item.image.toString(),
            fit: BoxFit.cover,
          );
  }
}
