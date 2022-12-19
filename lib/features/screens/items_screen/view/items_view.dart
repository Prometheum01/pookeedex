import 'package:flutter/material.dart';
import 'package:pookeedex/core/enum/list_enum.dart';

import 'package:pookeedex/features/screens/items_screen/view_model/items_view_model.dart';
import 'package:pookeedex/product/components/widgets.dart';

class ItemsView extends StatefulWidget {
  const ItemsView({super.key});

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends ItemsViewModel {
  @override
  Widget build(BuildContext context) {
    return ListTemplate(
        isPaginateLoading: isPaginateLoading,
        scrollController: listController,
        list: list,
        type: ListType.items);
  }
}
