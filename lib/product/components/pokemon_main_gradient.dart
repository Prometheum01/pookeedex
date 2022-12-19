import 'package:flutter/material.dart';
import 'package:pookeedex/product/constants/nature_constants.dart';
import 'package:pookeedex/product/model/pokemon_type.dart';

class PokemonMainGradient extends StatelessWidget {
  const PokemonMainGradient({
    Key? key,
    required this.pokemonType,
  }) : super(key: key);

  final PokemonType pokemonType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            NatureConst.checkNatureWithName(pokemonType.name)
                .natureColor
                .firstColor,
            NatureConst.checkNatureWithName(pokemonType.name)
                .natureColor
                .secondColor,
          ],
        ),
      ),
    );
  }
}
