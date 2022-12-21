import '../../enum/hive.dart';

abstract class IImageDownloader {
  downloadImageForCache(
      {required String image,
      required String id,
      required HiveEnum hiveEnum}) {}

  removeImageFromCache({required String path}) {}
}
