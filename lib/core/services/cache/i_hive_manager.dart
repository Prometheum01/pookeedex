// ignore_for_file: avoid_shadowing_type_parameters

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pookeedex/core/enum/hive.dart';

import '../../../product/model/ability.dart';
import '../../../product/model/breeding.dart';
import '../../../product/model/capture.dart';
import '../../../product/model/egg_group.dart';
import '../../../product/model/evolve.dart';
import '../../../product/model/item.dart';
import '../../../product/model/move.dart';
import '../../../product/model/nature.dart';
import '../../../product/model/nature_color.dart';
import '../../../product/model/pokemon.dart';
import '../../../product/model/pokemon_type.dart';
import '../../../product/model/stat.dart';

abstract class IHaveManager<T> {
  Future<void> initDB() async {
    await Hive.initFlutter();

    Hive.registerAdapter(AbilityAdapter());
    Hive.registerAdapter(BreedingAdapter());

    Hive.registerAdapter(CaptureAdapter());
    Hive.registerAdapter(EggGroupAdapter());

    Hive.registerAdapter(EvolveAdapter());
    Hive.registerAdapter(ItemAdapter());

    Hive.registerAdapter(MoveAdapter());
    Hive.registerAdapter(NatureColorAdapter());

    Hive.registerAdapter(NatureAdapter());
    Hive.registerAdapter(PokemonTypeAdapter());

    Hive.registerAdapter(PokemonAdapter());
    Hive.registerAdapter(StatAdapter());

    await Hive.openBox<bool>('onboard');

    await Hive.openBox<Pokemon>(HiveEnum.favorite_pokemon.name);
    await Hive.openBox<Move>(HiveEnum.favorite_moves.name);
    await Hive.openBox<Item>(HiveEnum.favorite_items.name);

    await Hive.openBox<Pokemon>(HiveEnum.initial_pokemon.name);
    await Hive.openBox<Move>(HiveEnum.initial_moves.name);
    await Hive.openBox<Item>(HiveEnum.initial_items.name);
  }

  Future<void> addMultipleData<T>(
      {required List<T> data, required HiveEnum hiveEnum}) async {}

  addDataToBox<T>({required T data, required HiveEnum hiveEnum}) {}

  readDataFromBox<T>(HiveEnum hiveEnum) {}

  deleteDataFromBox<T>(
      {required T data, required HiveEnum hiveEnum, bool deleteImage = true}) {}

  checkDataInBox<T>({required T data, required HiveEnum hiveEnum}) {}
}
