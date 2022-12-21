import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pookeedex/core/services/connectivity/network_connectivity.dart';
import 'package:pookeedex/product/model/move.dart';

import '../../../product/model/item.dart';
import '../../../product/model/pokemon.dart';
import '../../../product/services/network/pokemon_service.dart';

class MainScreenProvider extends ChangeNotifier {
  InternetConnectionStatus? _connection;

  listenConnection() async {
    await checkAndFetchInitialList();
    NetworkConnectivity().handleNetworkConnectivity((result) async {
      await checkAndFetchInitialList();
      _connection = result;

      notifyListeners();
    });
  }

  checkAndFetchInitialList() async {
    changeLoadingMain();

    if (!isInitialValuesLoaded) {
      if (await checkConnection == InternetConnectionStatus.disconnected) {
      } else {
        List<Pokemon> pookeeList = [];
        List<Move> movesList = [];
        List<Item> itemsList = [];

        if (loadedPokemonList.isEmpty) {
          pookeeList = await PookeeService().fetchPokemons();
        }
        if (loadedMoveList.isEmpty) {
          movesList = await PookeeService().fetchMoves();
        }

        if (loadedItemList.isEmpty) {
          itemsList = await PookeeService().fetchItems();
        }

        setLoadedPokemonList(pookeeList);
        setLoadedMoveList(movesList);
        setLoadedItemList(itemsList);
      }
    }
    changeLoadingMain();
  }

  bool get isInitialValuesLoaded =>
      _loadedPokemonList.isNotEmpty &&
      _loadedMoveList.isNotEmpty &&
      _loadedItemList.isNotEmpty;

  InternetConnectionStatus get connection =>
      _connection ?? InternetConnectionStatus.disconnected;

  Future<InternetConnectionStatus> get checkConnection async =>
      await NetworkConnectivity().checkNetworkConnectivity();

  bool _isPaginateLoadingItems = false;

  bool _isPaginateLoadingMoves = false;

  bool _isPaginateLoadingHome = false;

  bool _isLoadingMain = false;

  List<Item> _loadedItemList = [];

  List<Move> _loadedMoveList = [];

  List<Pokemon> _loadedPokemonList = [];

  int _currentScreenIndex = 0;

  late final PageController _pageController;

  void changeScreen(int newScreenIndex) {
    _currentScreenIndex = newScreenIndex;
    _pageController.animateToPage(_currentScreenIndex,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
    notifyListeners();
  }

  void setPageController(PageController pageController) {
    _pageController = pageController;
  }

  void setLoadedItemList(List<Item> itemList) {
    _loadedItemList = itemList;
    notifyListeners();
  }

  void setLoadedMoveList(List<Move> moveList) {
    _loadedMoveList = moveList;
    notifyListeners();
  }

  void setLoadedPokemonList(List<Pokemon> pokemonList) {
    _loadedPokemonList = pokemonList;
    notifyListeners();
  }

  changePaginateLoadingItems({bool? newState}) {
    if (newState == null) {
      _isPaginateLoadingItems = !_isPaginateLoadingItems;
      notifyListeners();
    } else {
      _isPaginateLoadingItems = newState;
    }
  }

  bool get isPaginateLoadingItems => _isPaginateLoadingItems;

  changePaginateLoadingMoves({bool? newState}) {
    if (newState == null) {
      _isPaginateLoadingMoves = !_isPaginateLoadingMoves;
      notifyListeners();
    } else {
      _isPaginateLoadingMoves = newState;
    }
  }

  bool get isPaginateLoadingMoves => _isPaginateLoadingMoves;

  changePaginateLoadingHome({bool? newState}) {
    if (newState == null) {
      _isPaginateLoadingHome = !_isPaginateLoadingHome;
      notifyListeners();
    } else {
      _isPaginateLoadingHome = newState;
    }
  }

  bool get isPaginateLoadingHome => _isPaginateLoadingHome;

  changeLoadingMain({bool? newState}) {
    if (newState == null) {
      _isLoadingMain = !_isLoadingMain;
      notifyListeners();
    } else {
      _isLoadingMain = newState;
    }
  }

  bool get isLoadingMain => _isLoadingMain;

  String get selectedTabName {
    switch (_currentScreenIndex) {
      case 0:
        return "Pokemon";
      case 1:
        return "Moves";
      case 2:
        return "Items";
      case 3:
        return "Favorite";
      default:
        return "Pokemon";
    }
  }

  List<Item> get loadedItemList => _loadedItemList;

  List<Move> get loadedMoveList => _loadedMoveList;

  List<Pokemon> get loadedPokemonList => _loadedPokemonList;

  PageController get pageController => _pageController;

  int get currentScreenIndex => _currentScreenIndex;
}
