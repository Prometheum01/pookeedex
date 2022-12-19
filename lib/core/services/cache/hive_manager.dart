import 'package:hive/hive.dart';
import 'package:pookeedex/core/services/cache/i_hive_manager.dart';

import '../../constants/hive_const.dart';

class HiveManager extends IHaveManager {
  @override
  addDataToBox<T>({required T data}) {
    Box<T> box = Hive.box(HiveConst.typeToString<T>());

    box.add(data);
  }

  @override
  Box<T> readDataFromBox<T>() {
    Box<T> box = Hive.box(HiveConst.typeToString<T>());

    return box;
  }
}
