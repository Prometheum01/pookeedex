// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/core/services/cache/hive_manager.dart';
import 'package:pookeedex/product/model/item.dart';
import 'package:pookeedex/product/model/move.dart';
import 'package:pookeedex/product/model/pokemon.dart';

class CacheProvider extends ChangeNotifier {
  HiveManager hiveManager = HiveManager();

  //Vars

  bool _pookeeCacheLoading = false;

  bool _moveCacheLoading = false;

  bool _itemCacheLoading = false;

  List<Pokemon> _pookeeList = [];

  List<Move> _moveList = [];

  List<Item> _itemList = [];

  //Functions

  void initializeLists() {
    //If there is data from db it takes them

    List<Pokemon> tempPokeList = hiveManager
        .readDataFromBox<Pokemon>(HiveEnum.favorite_pokemon)
        .values
        .toList();

    _pookeeList = tempPokeList.isNotEmpty
        ? (_pookeeList == tempPokeList ? _pookeeList : tempPokeList)
        : [];

    List<Move> tempMoveList = hiveManager
        .readDataFromBox<Move>(HiveEnum.favorite_moves)
        .values
        .toList();

    _moveList = tempMoveList.isNotEmpty ? tempMoveList : [];

    List<Item> tempItemList = hiveManager
        .readDataFromBox<Item>(HiveEnum.favorite_items)
        .values
        .toList();

    _itemList = tempItemList.isNotEmpty ? tempItemList : [];

    notifyListeners();
  }

  void changePookeeCacheLoading({bool? newLoading}) {
    if (newLoading != null) {
      _pookeeCacheLoading = newLoading;
    } else {
      _pookeeCacheLoading = !_pookeeCacheLoading;
      notifyListeners();
    }
  }

  void changeMoveCacheLoading({bool? newLoading}) {
    if (newLoading != null) {
      _moveCacheLoading = newLoading;
    } else {
      _moveCacheLoading = !_moveCacheLoading;
      notifyListeners();
    }
  }

  void changeItemCacheLoading({bool? newLoading}) {
    if (newLoading != null) {
      _itemCacheLoading = newLoading;
    } else {
      _itemCacheLoading = !_itemCacheLoading;
      notifyListeners();
    }
  }

  //Getter

  List<Pokemon> get pookeeList => _pookeeList;

  List<Move> get moveList => _moveList;

  List<Item> get itemList => _itemList;

  bool get pookeeCacheLoading => _pookeeCacheLoading;

  bool get moveCacheLoading => _moveCacheLoading;

  bool get itemCacheLoading => _itemCacheLoading;
}
