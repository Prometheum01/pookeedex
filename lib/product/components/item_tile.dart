import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/constants/color_const.dart';
import 'package:pookeedex/product/components/cached_image.dart';

import '../../core/enum/hive.dart';
import '../../core/services/navigator/navigator_service.dart';
import '../model/item.dart';
import 'widgets.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(NavigatorKeys.item_detail.path,
            arguments: {"item": item});
      },
      child: Ink(
        color: Colors.white,
        child: ListTile(
          leading: SizedBox(
            height: context.dynamicHeight(0.05),
            width: context.dynamicHeight(0.05),
            child: ItemCachedImage(
              item: item,
            ),
          ),
          title: Text(
            item.name.toTitleCase(),
            style: context.textTheme.headline5,
          ),
          trailing: SizedBox(
            width: context.dynamicWidth(0.15),
            child: CostWidget(color: ColorConst.highTextColor, cost: item.cost),
          ),
        ),
      ),
    );
  }
}
