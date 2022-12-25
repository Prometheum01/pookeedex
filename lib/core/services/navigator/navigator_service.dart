// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pookeedex/features/screens/after_search_screen/view/after_search_view.dart';
import 'package:pookeedex/features/screens/detail_screen/view/detail_view.dart';
import 'package:pookeedex/features/screens/favorite_screen/view/favorite_view.dart';
import 'package:pookeedex/features/screens/home_screen/view/home_view.dart';
import 'package:pookeedex/features/screens/main_screen/view/main_view.dart';
import 'package:pookeedex/features/screens/onboard_screen/view/onboard_view.dart';
import 'package:pookeedex/features/screens/splash_screen/view/splash_view.dart';

import '../../../features/screens/item_detail_screen/view/item_detail_view.dart';
import '../../../features/screens/moves_detail_screen/view/moves_detail_view.dart';

enum NavigatorKeys {
  main,
  home,
  detail,
  after_searched,
  moves_detail,
  item_detail,
  favorite,
  splash,
  onboard,
}

extension NavigatorExtension on NavigatorKeys {
  get path => '/$name';
}

class NavigatorService {
  static Map<String, Widget Function(BuildContext)> navigatorKeys = {
    NavigatorKeys.splash.path: (context) => const SplashView(),
    NavigatorKeys.main.path: (context) => const MainView(),
    NavigatorKeys.home.path: (context) => const HomeView(),
    NavigatorKeys.detail.path: (context) => const DetailView(),
    NavigatorKeys.after_searched.path: (context) => const AfterSearchView(),
    NavigatorKeys.moves_detail.path: (context) => const MovesDetailView(),
    NavigatorKeys.item_detail.path: (context) => const ItemDetailView(),
    NavigatorKeys.favorite.path: (context) => const FavoriteView(),
    NavigatorKeys.onboard.path: (context) => const OnboardView(),
  };
}
