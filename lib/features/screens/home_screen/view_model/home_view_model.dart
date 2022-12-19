// ignore_for_file: use_build_context_synchronously

import 'package:pookeedex/core/services/provider/main_screen_provider.dart';
import 'package:pookeedex/features/interface/i_list_model.dart';
import 'package:pookeedex/product/services/network/pokemon_service.dart';
import 'package:provider/provider.dart';

import '../../../../product/model/pokemon.dart';
import '../view/home_view.dart';

abstract class HomeViewModel extends IListModel<HomeView> {
  @override
  Future<void> paginateList() async {
    var list = context.read<MainScreenProvider>().loadedPokemonList;

    context.read<MainScreenProvider>().changePaginateLoadingHome();
    if (list.isNotEmpty) {
      context.read<MainScreenProvider>().setLoadedPokemonList(list +
          await PookeeService().fetchPokemons(
              page: (list.length ~/ DATA_PER_PAGE),
              pokemonPerPage: DATA_PER_PAGE));
    }

    context.read<MainScreenProvider>().changePaginateLoadingHome();
  }

  @override
  bool get isPaginateLoading =>
      context.read<MainScreenProvider>().isPaginateLoadingHome;

  @override
  List<Pokemon> get list =>
      context.watch<MainScreenProvider>().loadedPokemonList;
}
