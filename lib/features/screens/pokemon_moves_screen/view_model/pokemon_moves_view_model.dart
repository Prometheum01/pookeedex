import 'package:flutter/material.dart';
import 'package:pookeedex/features/interface/i_list_model.dart';
import 'package:pookeedex/features/screens/pokemon_moves_screen/view/pokemon_moves_view.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/provider/pookee_provider.dart';
import '../../../../product/model/move.dart';
import '../../../../product/model/pokemon.dart';
import '../../../../product/services/network/pokemon_service.dart';

abstract class PokemonMovesViewModel extends IListModel<PokemonMovesView> {
  late Pokemon pookee;

  @override
  void initState() {
    super.initState();
    context.read<PookeeProvider>().changeLoadingMoves(newState: true);

    Future.microtask(() => loadMoves());
  }

  Future<void> loadMoves() async {
    pookee = context.read<PookeeProvider>().pookee;
    await checkInternet(
        function: () async {
          if (pookee.moves == null) {
            context.read<PookeeProvider>().setMovesList(
                  await PookeeService().fetchPokemonMoves(
                    id: pookee.id.toString(),
                  ),
                );
          }
        },
        errorWidget: const Text("There is no internet connection!"));

    // ignore: use_build_context_synchronously
    context.read<PookeeProvider>().changeLoadingMoves();
  }

  @override
  Future<void> paginateList() async {
    var list = context.read<PookeeProvider>().pookee.moves!;

    context.read<PookeeProvider>().changePaginateLoadingMoves();
    if (list.isNotEmpty) {
      context.read<PookeeProvider>().setMovesList(
            list +
                await PookeeService().fetchPokemonMoves(
                    id: pookee.id.toString(),
                    offset: (list.length ~/ DATA_PER_PAGE),
                    perPage: DATA_PER_PAGE),
          );
    }

    // ignore: use_build_context_synchronously
    context.read<PookeeProvider>().changePaginateLoadingMoves();
  }

  @override
  bool get isPaginateLoading =>
      context.read<PookeeProvider>().isPaginateLoadingMoves;

  bool get isLoading => context.read<PookeeProvider>().isLoadingMoves;

  @override
  List<Move>? get list => context.watch<PookeeProvider>().pookee.moves;
}
