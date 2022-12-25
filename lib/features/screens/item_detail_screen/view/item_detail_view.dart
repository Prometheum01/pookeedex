import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/constants/color_const.dart';
import 'package:pookeedex/core/constants/padding_const.dart';
import 'package:pookeedex/product/components/widgets.dart';
import 'package:pookeedex/product/model/item.dart';

import '../../../../core/enum/hive.dart';

class ItemDetailView extends StatelessWidget {
  const ItemDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Item item =
        (ModalRoute.of(context)?.settings.arguments as Map)['item'];

    return SafeArea(
      child: Stack(
        children: [
          const MainGradient(),
          Container(
            color: Colors.white.withOpacity(0.6),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Transform.rotate(
              angle: 0,
              child: SizedBox(
                height: context.dynamicHeight(0.5),
                child: CachedItemImage(
                  item: item,
                  color: Colors.white.withOpacity(0.25),
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              actions: [
                FavoriteButton<Item>(
                    data: item, hiveEnum: HiveEnum.favorite_items),
              ],
            ),
            body: ListView(
              children: [
                PageBackground(
                  height: context.dynamicHeight(1),
                  backgroundPaddingFromTop: context.dynamicHeight(0.2),
                  childPaddingFromTop: context.dynamicHeight(0.1),
                  child: Column(
                    children: [
                      SizedBox(
                        height: context.dynamicHeight(
                          0.2,
                        ),
                        width: context.dynamicHeight(
                          0.2,
                        ),
                        child: CachedItemImage(item: item),
                      ),
                      Padding(
                        padding: const PaddingConst.largeVertical(),
                        child: Text(
                          item.name,
                          style: context.textTheme.headline4,
                        ),
                      ),
                      CostWidget(
                          cost: item.cost,
                          color: ColorConst.lowTextColor,
                          align: MainAxisAlignment.center),
                      Padding(
                        padding: const PaddingConst.largeVertical(),
                        child: Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: context.textTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
