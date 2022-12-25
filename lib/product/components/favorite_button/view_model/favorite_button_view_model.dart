import 'package:pookeedex/product/components/favorite_button/view/favorite_button_view.dart';

import '../../../../core/services/cache/hive_manager.dart';
import '../interface/i_favorite_button.dart';

abstract class FavoriteButtonViewModel<T>
    extends IFavoriteButton<FavoriteButton<T>> {
  @override
  void initState() {
    super.initState();
    checkIsHas();
  }

  @override
  checkIsHas() {
    setIsHas(HiveManager()
        .checkDataInBox<T>(data: widget.data, hiveEnum: widget.hiveEnum));
  }
}
