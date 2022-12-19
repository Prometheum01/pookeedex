import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pookeedex/core/constants/hive_const.dart';
import 'package:pookeedex/core/services/cache/hive_manager.dart';
import 'package:pookeedex/product/model/item.dart';
import 'package:pookeedex/product/model/move.dart';
import 'package:pookeedex/product/model/pokemon.dart';

import '../view/favorite_view.dart';

abstract class FavoriteViewModel extends State<FavoriteView> {
  late Box<Pokemon> pookeeBox;
  late Box<Move> moveBox;
  late Box<Item> itemBox;
  @override
  void initState() {
    super.initState();
    pookeeBox = HiveManager().readDataFromBox<Pokemon>();
    moveBox = HiveManager().readDataFromBox<Move>();
    itemBox = HiveManager().readDataFromBox<Item>();
  }
}
