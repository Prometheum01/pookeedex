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
  Future<bool> addDataToBox<T>(
      {required T data, required HiveEnum hiveEnum}) async {
    bool isHas = checkDataInBox(data: data, hiveEnum: hiveEnum);

    if (isHas) {
      deleteDataFromBox(data: data, hiveEnum: hiveEnum);
      return true;
    } else {
      if (await NetworkConnectivity().checkNetworkConnectivity() ==
          InternetConnectionStatus.disconnected) {
        print("There is no Internet");
        return false;
      } else {
        Box<T> box = Hive.box(hiveEnum.name);

        try {
          switch (hiveEnum) {
            case HiveEnum.favorite_pokemon:
              await ImageDownloader.downloadImage(
                (data as Pokemon).image,
                destination: AndroidDestinationType.custom(
                    directory: HiveEnum.favorite_pokemon.name)
                  ..inExternalFilesDir()
                  ..subDirectory("images/${data.id}.png"),
              );
              break;
            case HiveEnum.favorite_moves:
              break;
            case HiveEnum.favorite_items:
              await ImageDownloader.downloadImage(
                (data as Item).image,
                destination: AndroidDestinationType.custom(
                    directory: HiveEnum.favorite_items.name)
                  ..inExternalFilesDir()
                  ..subDirectory("images/${data.id}.png"),
              );
              break;
            default:
          }
        } on PlatformException catch (error) {
          print(error);
          return false;
        }

        box.add(data);
        return true;
      }
    }
  }

  @override
  Box<T> readDataFromBox<T>(HiveEnum hiveEnum) {
    Box<T> box = Hive.box(hiveEnum.name);

    return box;
  }

  @override
  void deleteDataFromBox<T>({required T data, required HiveEnum hiveEnum}) {
    Box<T> box = Hive.box(hiveEnum.name);

    box.deleteAt(box.values.toList().indexOf(data));
  }

  @override
  bool checkDataInBox<T>({required T data, required HiveEnum hiveEnum}) {
    return readDataFromBox<T>(hiveEnum).values.contains(data);
  }
}
