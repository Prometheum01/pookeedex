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

  initializeLists() {
    //If there is data from db it takes them

    _pookeeList = hiveManager
            .readDataFromBox<Pokemon>(HiveEnum.favorite_pokemon)
            .isNotEmpty
        ? hiveManager
            .readDataFromBox<Pokemon>(HiveEnum.favorite_pokemon)
            .values
            .toList()
        : [];

    _moveList =
        hiveManager.readDataFromBox<Move>(HiveEnum.favorite_moves).isNotEmpty
            ? hiveManager
                .readDataFromBox<Move>(HiveEnum.favorite_moves)
                .values
                .toList()
            : [];

    _itemList =
        hiveManager.readDataFromBox<Item>(HiveEnum.favorite_items).isNotEmpty
            ? hiveManager
                .readDataFromBox<Item>(HiveEnum.favorite_items)
                .values
                .toList()
            : [];

    notifyListeners();
  }

  //Getter
  List<Pokemon> get pookeeList => _pookeeList;

  List<Move> get moveList => _moveList;

  List<Item> get itemList => _itemList;
}
