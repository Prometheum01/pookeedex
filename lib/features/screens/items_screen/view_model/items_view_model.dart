// ignore_for_file: use_build_context_synchronously

import 'package:pookeedex/features/interface/i_list_model.dart';
import 'package:pookeedex/product/model/item.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/provider/main_screen_provider.dart';
import '../../../../product/services/network/pokemon_service.dart';
import '../view/items_view.dart';

abstract class ItemsViewModel extends IListModel<ItemsView> {
  @override
  Future<void> paginateList() async {
    var list = context.read<MainScreenProvider>().loadedItemList;

    context.read<MainScreenProvider>().changePaginateLoadingItems();
    if (list.isNotEmpty) {
      context.read<MainScreenProvider>().setLoadedItemList(list +
          await PookeeService().fetchItems(
              page: (list.length ~/ DATA_PER_PAGE),
              itemPerPage: DATA_PER_PAGE));
    }

    context.read<MainScreenProvider>().changePaginateLoadingItems();
  }

  @override
  bool get isPaginateLoading =>
      context.read<MainScreenProvider>().isPaginateLoadingItems;

  @override
  List<Item> get list => context.watch<MainScreenProvider>().loadedItemList;
}
