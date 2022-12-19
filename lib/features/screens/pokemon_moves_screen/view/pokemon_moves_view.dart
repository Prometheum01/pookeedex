import 'package:flutter/material.dart';
import 'package:pookeedex/core/enum/list_enum.dart';
import 'package:pookeedex/product/components/widgets.dart';

import '../view_model/pokemon_moves_view_model.dart';

class PokemonMovesView extends StatefulWidget {
  const PokemonMovesView({super.key});

  @override
  State<PokemonMovesView> createState() => _PokemonMovesViewState();
}

class _PokemonMovesViewState extends PokemonMovesViewModel {
  @override
  Widget build(BuildContext context) {
    return ListTemplate(
        isLoading: isLoading,
        isPaginateLoading: isPaginateLoading,
        scrollController: listController,
        list: list ?? [],
        type: ListType.moves);
  }
}
