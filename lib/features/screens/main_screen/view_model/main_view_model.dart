// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pookeedex/core/services/provider/main_screen_provider.dart';
import 'package:pookeedex/product/model/item.dart';
import 'package:pookeedex/product/model/move.dart';
import 'package:pookeedex/product/model/pokemon.dart';
import 'package:provider/provider.dart';

import '../../../../product/services/network/pokemon_service.dart';
import '../view/main_view.dart';

abstract class MainViewModel extends State<MainView> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    context.read<MainScreenProvider>().setPageController(pageController);

    context.read<MainScreenProvider>().listenConnection();
  }

  Future<void> getLists() async {
    if (await context.read<MainScreenProvider>().checkConnection ==
        InternetConnectionStatus.disconnected) {
    } else {
      List<Pokemon> pookeeList = [];
      List<Move> movesList = [];
      List<Item> itemsList = [];

      if (context.read<MainScreenProvider>().loadedPokemonList.isEmpty) {
        pookeeList = await PookeeService().fetchPokemons();
      }
      if (context.read<MainScreenProvider>().loadedMoveList.isEmpty) {
        movesList = await PookeeService().fetchMoves();
      }

      if (context.read<MainScreenProvider>().loadedItemList.isEmpty) {
        itemsList = await PookeeService().fetchItems();
      }

      context.read<MainScreenProvider>().setLoadedPokemonList(pookeeList);
      context.read<MainScreenProvider>().setLoadedMoveList(movesList);
      context.read<MainScreenProvider>().setLoadedItemList(itemsList);
    }

    context.read<MainScreenProvider>().changeLoadingMain();
  }

  bool get isLoading => context.watch<MainScreenProvider>().isLoadingMain;
}
