import 'package:flutter/material.dart';
import 'package:pookeedex/core/enum/list_enum.dart';
import 'package:pookeedex/features/screens/favorite_screen/view_model/favorite_view_model.dart';

import '../../../../product/components/favorite_list_template.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends FavoriteViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          FavoriteListTemplate(list: pookeeList, type: ListType.pokemon),
          FavoriteListTemplate(list: moveList, type: ListType.moves),
          FavoriteListTemplate(list: itemList, type: ListType.items),
        ],
      ),
    );
  }
}
