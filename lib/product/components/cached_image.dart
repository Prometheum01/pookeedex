import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pookeedex/product/model/item.dart';
import 'package:pookeedex/product/model/pokemon.dart';

class CachedItemImage extends StatelessWidget {
  const CachedItemImage({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    print(item.cacheImageToken);
    return item.cacheImageToken != null
        ? Image.file(
            File(
              item.cacheImageToken!,
            ),
            fit: BoxFit.cover,
          )
        : Image.network(
            item.image,
            fit: BoxFit.cover,
          );
  }
}

class CachedPokemonImage extends StatelessWidget {
  const CachedPokemonImage({super.key, required this.pookee});

  final Pokemon pookee;

  @override
  Widget build(BuildContext context) {
    return pookee.cacheImageToken != null
        ? Image.file(
            File(
              pookee.cacheImageToken!,
            ),
            fit: BoxFit.cover,
          )
        : Image.network(
            pookee.image,
            fit: BoxFit.cover,
          );
  }
}
