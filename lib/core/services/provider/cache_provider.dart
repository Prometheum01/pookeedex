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

    print(_pookeeList == tempPokeList);

    _pookeeList = tempPokeList.isNotEmpty
        ? (_pookeeList == tempPokeList ? _pookeeList : tempPokeList)
        : [];

    List<Move> tempMoveList = hiveManager
        .readDataFromBox<Move>(HiveEnum.favorite_moves)
        .values
        .toList();

    print(_moveList == tempMoveList);

    _moveList = tempMoveList.isNotEmpty ? tempMoveList : [];

    List<Item> tempItemList = hiveManager
        .readDataFromBox<Item>(HiveEnum.favorite_items)
        .values
        .toList();

    print(_itemList == tempItemList);

    _itemList = tempItemList.isNotEmpty ? tempItemList : [];

    notifyListeners();
  }

  //Getter

  List<Pokemon> get pookeeList => _pookeeList;

  List<Move> get moveList => _moveList;

  List<Item> get itemList => _itemList;
}
