import 'dart:io';

import 'package:image_downloader/image_downloader.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/core/services/image_downloader/i_image_downloader.dart';

class ImageDownloaderCache extends IImageDownloader {
  @override
  Future<String?> downloadImageForCache(
      {required String image,
      required String id,
      required HiveEnum hiveEnum}) async {
    try {
      String? token = await ImageDownloader.downloadImage(
        image,
        destination: AndroidDestinationType.custom(directory: hiveEnum.name)
          ..inExternalFilesDir()
          ..subDirectory("images/$id.png"),
      );
      if (token != null) {
        return await ImageDownloader.findPath(token);
      }
      return null;
    } catch (e) {
      print("Image Download error");
      return null;
    }
  }

  @override
  removeImageFromCache({required String path}) async {
    await File(path).delete();
  }
}
