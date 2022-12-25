import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/core/services/cache/hive_manager.dart';
import 'package:pookeedex/core/services/connectivity/network_connectivity.dart';
import 'package:pookeedex/core/services/permission/permission_manager.dart';
import 'package:pookeedex/product/model/move.dart';

import '../../../product/model/item.dart';
import '../../../product/model/pokemon.dart';
import '../../../product/services/network/pokemon_service.dart';

class MainScreenProvider extends ChangeNotifier {
  //Variables

  // ignore: non_constant_identifier_names
  final int INITIAL_LIST_LENGTH = 10;

  int _currentScreenIndex = 0;

  int _currentFavoriteScreenIndex = 0;

  bool _isPaginateLoadingItems = false;

  bool _isPaginateLoadingMoves = false;

  bool _isPaginateLoadingHome = false;

  bool _isLoadingMain = false;

  bool _cacheLoading = false;

  List<Pokemon> _loadedPokemonList = [];

  List<Move> _loadedMoveList = [];

  List<Item> _loadedItemList = [];

  late final PageController _pageController;

  PageController? _favoritePageController;

  InternetConnectionStatus? _connection;

  //Functions

  listenConnection() async {
    NetworkConnectivity().handleNetworkConnectivity((result) async {
      InternetConnectionStatus? beforeStatus = _connection;

      _connection = result;
      notifyListeners();

      print("a");
      if (result == InternetConnectionStatus.connected &&
          beforeStatus == InternetConnectionStatus.disconnected) {
        print("b");
        await checkAndFetchInitialList();
        cacheInitialValues();
      }
    });
  }

  Future<void> checkAndFetchInitialList() async {
    print("1");
    if (!_isLoadingMain) {
      changeLoadingMain();
      print("2");
      if (!isInitialValuesLoaded) {
        print("3");
        //If internet and initial values not

        if (initialPokemonFromHive.length >= INITIAL_LIST_LENGTH) {
          _loadedPokemonList = initialPokemonFromHive;
        } else {
          _loadedPokemonList += initialPokemonFromHive;
          if (await checkConnection == InternetConnectionStatus.connected) {
            if (initialPokemonFromHive.isEmpty) {
              _loadedPokemonList += await PookeeService().fetchPokemons();
            } else {
              _loadedPokemonList += await PookeeService().fetchPokemons(
                page: _loadedPokemonList.length,
                pokemonPerPage: INITIAL_LIST_LENGTH - _loadedPokemonList.length,
                notPage: true,
              );
            }
          } else {
            print("There is no internet");
          }
        }

        if (initialMovesFromHive.length >= INITIAL_LIST_LENGTH) {
          _loadedMoveList = initialMovesFromHive;
        } else {
          if (await checkConnection == InternetConnectionStatus.connected) {
            if (initialMovesFromHive.isEmpty) {
              _loadedMoveList += await PookeeService().fetchMoves();
            } else {
              _loadedMoveList += initialMovesFromHive;

              _loadedMoveList += await PookeeService().fetchMoves(
                page: _loadedMoveList.length + 1,
                movesPerPage: INITIAL_LIST_LENGTH - _loadedMoveList.length - 1,
                notPage: true,
              );
            }
          }
        }

        if (initialItemsFromHive.length >= INITIAL_LIST_LENGTH) {
          _loadedItemList = initialItemsFromHive;
        } else {
          _loadedItemList += initialItemsFromHive;

          if (await checkConnection == InternetConnectionStatus.connected) {
            if (initialItemsFromHive.isEmpty) {
              _loadedItemList += await PookeeService().fetchItems();
            } else {
              _loadedItemList += await PookeeService().fetchItems(
                page: _loadedItemList.length,
                itemPerPage: INITIAL_LIST_LENGTH - _loadedItemList.length,
                notPage: true,
              );
            }
          }
        }
        print("4");
      }

      changeLoadingMain();
    }
  }

  Future<void> cacheInitialValues() async {
    if (await PermissionManager().hasPermissionForStorage) {
      changeCacheLoading();

      if (_loadedPokemonList.length <= INITIAL_LIST_LENGTH) {
        await HiveManager().addMultipleData<Pokemon>(
          data: _loadedPokemonList.sublist(
            initialPokemonFromHive.isEmpty
                ? 0
                : initialPokemonFromHive.length - 1,
          ),
          hiveEnum: HiveEnum.initial_pokemon,
        );
      }

      if (_loadedMoveList.length <= INITIAL_LIST_LENGTH) {
        await HiveManager().addMultipleData<Move>(
          data: _loadedMoveList.sublist(
            initialMovesFromHive.isEmpty ? 0 : initialMovesFromHive.length,
          ),
          hiveEnum: HiveEnum.initial_moves,
        );
      }

      if (initialItemsFromHive.length <= INITIAL_LIST_LENGTH) {
        await HiveManager().addMultipleData<Item>(
          data: _loadedItemList.sublist(
            initialItemsFromHive.isEmpty ? 0 : initialItemsFromHive.length,
          ),
          hiveEnum: HiveEnum.initial_items,
        );
      }

      changeCacheLoading();
    }
  }

  void changeScreen(int newScreenIndex) {
    _currentScreenIndex = newScreenIndex;
    _pageController.animateToPage(_currentScreenIndex,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
    notifyListeners();
  }

  void changeFavoriteScreen(int newScreenIndex) {
    _currentFavoriteScreenIndex = newScreenIndex;
    _favoritePageController!.animateToPage(_currentFavoriteScreenIndex,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);

    notifyListeners();
  }

  void setPageController(PageController pageController) {
    _pageController = pageController;
  }

  void setFavoritePageController(PageController pageController) {
    _favoritePageController = pageController;
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

  changePaginateLoadingMoves({bool? newState}) {
    if (newState == null) {
      _isPaginateLoadingMoves = !_isPaginateLoadingMoves;
      notifyListeners();
    } else {
      _isPaginateLoadingMoves = newState;
    }
  }

  changePaginateLoadingHome({bool? newState}) {
    if (newState == null) {
      _isPaginateLoadingHome = !_isPaginateLoadingHome;
      notifyListeners();
    } else {
      _isPaginateLoadingHome = newState;
    }
  }

  changeLoadingMain({bool? newState}) {
    if (newState == null) {
      _isLoadingMain = !_isLoadingMain;
      notifyListeners();
    } else {
      _isLoadingMain = newState;
    }
  }

  changeCacheLoading() {
    _cacheLoading = !_cacheLoading;
    notifyListeners();
  }

  //Getter Functions

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

  int get currentScreenIndex => _currentScreenIndex;

  int get currentFavoriteScreenIndex => _currentFavoriteScreenIndex;

  bool get isInitialValuesLoaded =>
      _loadedPokemonList.isNotEmpty &&
      _loadedMoveList.isNotEmpty &&
      _loadedItemList.isNotEmpty;

  bool get isPaginateLoadingMoves => _isPaginateLoadingMoves;

  bool get isPaginateLoadingItems => _isPaginateLoadingItems;

  bool get isPaginateLoadingHome => _isPaginateLoadingHome;

  bool get isLoadingMain => _isLoadingMain;

  bool get cacheLoading => _cacheLoading;

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

  List<Pokemon> get loadedPokemonList => _loadedPokemonList;

  List<Move> get loadedMoveList => _loadedMoveList;

  List<Item> get loadedItemList => _loadedItemList;

  InternetConnectionStatus get connection =>
      _connection ?? InternetConnectionStatus.disconnected;

  Future<InternetConnectionStatus> get checkConnection async =>
      await NetworkConnectivity().checkNetworkConnectivity();
}
