import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pookeedex/product/model/item.dart';
import 'package:pookeedex/product/model/pokemon.dart';

class CachedItemImage extends StatelessWidget {
  const CachedItemImage({super.key, required this.item, this.color});

  final Item item;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return item.cacheImageToken != null
        ? Image.file(
            File(
              item.cacheImageToken!,
            ),
            fit: BoxFit.cover,
            color: color,
          )
        : Image.network(
            item.image,
            fit: BoxFit.cover,
            color: color,
          );
  }
}

class CachedPokemonImage extends StatelessWidget {
  const CachedPokemonImage({super.key, required this.pookee, this.color});

  final Pokemon pookee;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return pookee.cacheImageToken != null
        ? Image.file(
            File(
              pookee.cacheImageToken!,
            ),
            fit: BoxFit.cover,
            color: color,
          )
        : Image.network(
            pookee.image,
            fit: BoxFit.cover,
            color: color,
          );
  }
}
