import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/core/services/cache/hive_manager.dart';
import 'package:pookeedex/core/services/connectivity/network_connectivity.dart';
import 'package:pookeedex/product/model/move.dart';

import '../../../product/model/item.dart';
import '../../../product/model/pokemon.dart';
import '../../../product/services/network/pokemon_service.dart';

class MainScreenProvider extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  final int INITIAL_LIST_LENGTH = 10;

  InternetConnectionStatus? _connection;

  listenConnection() async {
    NetworkConnectivity().handleNetworkConnectivity((result) async {
      _connection = result;
      notifyListeners();
    });
  }

  Future<void> checkAndFetchInitialList() async {
    if (!_isLoadingMain) {
      changeLoadingMain();

      if (!isInitialValuesLoaded) {
        //If internet and initial values not

        if (initialPokemonFromHive.length == INITIAL_LIST_LENGTH) {
          _loadedPokemonList = initialPokemonFromHive;
        } else {
          if (await checkConnection == InternetConnectionStatus.connected) {
            if (_loadedPokemonList.isEmpty) {
              _loadedPokemonList += initialPokemonFromHive;

              _loadedPokemonList += await PookeeService().fetchPokemons(
                page: _loadedPokemonList.length,
                pokemonPerPage: INITIAL_LIST_LENGTH - _loadedPokemonList.length,
                notPage: true,
              );
            }
          }
        }

        if (initialMovesFromHive.length == INITIAL_LIST_LENGTH) {
          _loadedMoveList = initialMovesFromHive;
        } else {
          if (await checkConnection == InternetConnectionStatus.connected) {
            if (_loadedMoveList.isEmpty) {
              _loadedMoveList += initialMovesFromHive;

              _loadedMoveList += await PookeeService().fetchMoves(
                page: _loadedMoveList.length,
                movesPerPage: INITIAL_LIST_LENGTH - _loadedMoveList.length,
                notPage: true,
              );
            }
          }
        }

        if (initialItemsFromHive.length == INITIAL_LIST_LENGTH) {
          _loadedItemList = initialItemsFromHive;
        } else {
          if (await checkConnection == InternetConnectionStatus.connected) {
            if (_loadedItemList.isEmpty) {
              _loadedItemList += initialItemsFromHive;

              _loadedItemList += await PookeeService().fetchItems(
                page: _loadedItemList.length,
                itemPerPage: INITIAL_LIST_LENGTH - _loadedItemList.length,
                notPage: true,
              );
            }
          }
        }
      }

      changeLoadingMain();
    }
  }

  Future<void> cacheInitialValues() async {
    if (initialPokemonFromHive.length < INITIAL_LIST_LENGTH) {
      await HiveManager().addMultipleData<Pokemon>(
          data: _loadedPokemonList.sublist(
            initialPokemonFromHive.isEmpty
                ? 0
                : initialPokemonFromHive.length - 1,
          ),
          hiveEnum: HiveEnum.initial_pokemon);
    }

    if (initialMovesFromHive.length < INITIAL_LIST_LENGTH) {
      await HiveManager().addMultipleData<Move>(
          data: _loadedMoveList.sublist(
            initialMovesFromHive.isEmpty ? 0 : initialMovesFromHive.length - 1,
          ),
          hiveEnum: HiveEnum.initial_moves);
    }

    if (initialItemsFromHive.length < INITIAL_LIST_LENGTH) {
      await HiveManager().addMultipleData<Item>(
          data: _loadedItemList.sublist(
            initialItemsFromHive.isEmpty ? 0 : initialItemsFromHive.length - 1,
          ),
          hiveEnum: HiveEnum.initial_items);
    }

    print("succeeded");
  }

  List<Pokemon> get initialPokemonFromHive => HiveManager()
      .readDataFromBox<Pokemon>(HiveEnum.initial_pokemon)
      .values
      .toList();

  List<Move> get initialMovesFromHive => HiveManager()
      .readDataFromBox<Move>(HiveEnum.initial_moves)
      .values
      .toList();

  List<Item> get initialItemsFromHive => HiveManager()
      .readDataFromBox<Item>(HiveEnum.initial_items)
      .values
      .toList();

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
