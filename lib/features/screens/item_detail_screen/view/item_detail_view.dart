import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/constants/color_const.dart';
import 'package:pookeedex/core/constants/padding_const.dart';
import 'package:pookeedex/core/enum/hive.dart';
import 'package:pookeedex/product/components/widgets.dart';
import 'package:pookeedex/product/model/item.dart';

class ItemDetailView extends StatelessWidget {
  const ItemDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Item item =
        (ModalRoute.of(context)?.settings.arguments as Map)['item'];

    return Stack(
      children: [
        const MainGradient(),
        Container(
          color: Colors.white.withOpacity(0.6),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              FavoriteButton<Item>(
                  data: item, hiveEnum: HiveEnum.favorite_items),
            ],
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              PageBackground(
                height: context.dynamicHeight(1),
                backgroundPaddingFromTop: context.dynamicHeight(0.15),
                childPaddingFromTop: context.dynamicHeight(0.05),
                child: Column(
                  children: [
                    SizedBox(
                      height: context.dynamicHeight(
                        0.2,
                      ),
                      width: context.dynamicHeight(
                        0.2,
                      ),
                      child: ItemCachedImage(
                          item: item, type: HiveEnum.favorite_items),
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
    );
  }
}
