import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/core/services/cache/i_hive_manager.dart';
import 'package:pookeedex/core/services/connectivity/network_connectivity.dart';
import 'package:pookeedex/product/model/item.dart';
import 'package:pookeedex/product/model/pokemon.dart';

class HiveManager extends IHaveManager {
  @override
  Future<void> addDataToBox<T>(
      {required T data, required HiveEnum hiveEnum}) async {
    if (await NetworkConnectivity().checkNetworkConnectivity() ==
        InternetConnectionStatus.disconnected) {
      print("There is no Internet");
    } else {
      Box<T> box = Hive.box(hiveEnum.name);
      try {
        // Saved with this method.

        if (HiveEnum.favorite_pokemon == hiveEnum ||
            HiveEnum.initial_pokemon == hiveEnum) {
          await ImageDownloader.downloadImage(
            (data as Pokemon).image,
            destination: AndroidDestinationType.custom(
                directory: HiveEnum.pokemon_images.name)
              ..inExternalFilesDir()
              ..subDirectory("images/${data.id}.png"),
          );
        } else if (HiveEnum.favorite_items == hiveEnum ||
            hiveEnum == HiveEnum.initial_items) {
          await ImageDownloader.downloadImage(
            (data as Item).image,
            destination: AndroidDestinationType.custom(
                directory: HiveEnum.item_images.name)
              ..inExternalFilesDir()
              ..subDirectory("images/${data.id}.png"),
          );
        }
      } on PlatformException catch (error) {
        print(error);
      }
      box.add(data);
    }
  }

  @override
  Box<T> readDataFromBox<T>(HiveEnum hiveEnum) {
    Box<T> box = Hive.box(hiveEnum.name);

    return box;
  }

  @override
  deleteDataFromBox<T>({required int index, required HiveEnum hiveEnum}) {
    Box<T> box = Hive.box(hiveEnum.name);

    box.deleteAt(index);
  }

  @override
  checkDataInBox<T>({required T data, required HiveEnum hiveEnum}) {
    if (hiveEnum == HiveEnum.favorite_pokemon ||
        hiveEnum == HiveEnum.initial_pokemon) {
      return readDataFromBox<T>(HiveEnum.favorite_pokemon)
              .values
              .contains(data) ||
          readDataFromBox<T>(HiveEnum.initial_pokemon).values.contains(data);
    } else if (hiveEnum == HiveEnum.favorite_items ||
        hiveEnum == HiveEnum.initial_items) {
      return readDataFromBox<T>(HiveEnum.favorite_items)
              .values
              .contains(data) ||
          readDataFromBox<T>(HiveEnum.initial_items).values.contains(data);
    }
  }
}
