import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/enum/hive.dart';
import '../../core/services/cache/hive_manager.dart';
import '../model/item.dart';
import '../model/pokemon.dart';

class PookeeCachedImage extends StatelessWidget {
  const PookeeCachedImage({
    super.key,
    required this.pookee,
  });

  final Pokemon pookee;

  getPath() async {
    Directory dir = await getExternalStorageDirectory() ?? Directory("");

    return '${dir.path}/${HiveEnum.favorite_pokemon.name}/images/${pookee.id}.png';
  }

  @override
  Widget build(BuildContext context) {
    return HiveManager().checkDataInBox<Pokemon>(
            data: pookee, hiveEnum: HiveEnum.favorite_pokemon)
        ? Image.file(
            File(
              //TODO:Duzenle
              "/storage/emulated/0/Android/data/com.example.pookeedex/files/${HiveEnum.favorite_pokemon.name}/images/${pookee.id}.png",
            ),
          )
        : Image.network(
            pookee.image.toString(),
          );
  }
}

class ItemCachedImage extends StatelessWidget {
  const ItemCachedImage({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return HiveManager()
            .checkDataInBox<Item>(data: item, hiveEnum: HiveEnum.favorite_items)
        ? Image.file(
            File(
              //TODO:Duzenle
              "/storage/emulated/0/Android/data/com.example.pookeedex/files/${HiveEnum.favorite_items.name}/images/${item.id}.png",
            ),
            fit: BoxFit.cover,
          )
        : Image.network(
            item.image.toString(),
            fit: BoxFit.cover,
          );
  }
}
