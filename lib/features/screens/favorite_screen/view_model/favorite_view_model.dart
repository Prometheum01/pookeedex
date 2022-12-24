import 'package:flutter/material.dart';

import 'package:pookeedex/core/services/provider/cache_provider.dart';
import 'package:pookeedex/core/services/provider/main_screen_provider.dart';
import 'package:pookeedex/product/model/item.dart';
import 'package:pookeedex/product/model/move.dart';
import 'package:pookeedex/product/model/pokemon.dart';
import 'package:provider/provider.dart';

import '../view/favorite_view.dart';

abstract class FavoriteViewModel extends State<FavoriteView> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: currentIndex);

    context
        .read<MainScreenProvider>()
        .setFavoritePageController(pageController);
  }

  List<Pokemon> get pookeeList => context.watch<CacheProvider>().pookeeList;

  List<Move> get moveList => context.watch<CacheProvider>().moveList;

  List<Item> get itemList => context.watch<CacheProvider>().itemList;

  int get currentIndex =>
      context.read<MainScreenProvider>().currentFavoriteScreenIndex;
}
