import 'package:pookeedex/product/model/item.dart';
import 'package:pookeedex/product/model/move.dart';
import 'package:pookeedex/product/model/pokemon.dart';

class HiveConst {
  HiveConst._();

  static String favoritePokemon = "favorite_pokemon";

  static String favoriteMoves = "favorite_moves";

  static String favoriteItems = "favorite_items";

  static String typeToString<T>() {
    switch (T) {
      case Pokemon:
        return favoritePokemon;
      case Move:
        return favoriteMoves;
      case Item:
        return favoriteItems;
      default:
        return favoritePokemon;
    }
  }
}
