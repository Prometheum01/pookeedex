import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pookeedex/core/constants/asset_const.dart';
import 'package:pookeedex/product/model/item.dart';
import 'package:pookeedex/product/model/pokemon.dart';

import '../../core/constants/padding_const.dart';
import '../../core/enum/list_enum.dart';
import '../model/move.dart';
import 'widgets.dart';

class ListTemplate extends StatefulWidget {
  const ListTemplate({
    super.key,
    required this.isPaginateLoading,
    required this.scrollController,
    required this.list,
    required this.type,
    this.isLoading,
  });

  final bool isPaginateLoading;

  final bool? isLoading;

  final ScrollController scrollController;

  final List list;

  final ListType type;

  @override
  State<ListTemplate> createState() => _ListTemplateState();
}

class _ListTemplateState extends State<ListTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: widget.isLoading ?? false
          ? const Center(
              child: CustomLoading(),
            )
          : widget.list.isEmpty
              ? Padding(
                  padding: const PaddingConst.mediumHorizontal(),
                  child: AnimationWithText(
                    animationPath: AssetConst.lostConnection,
                    text:
                        "You should connect internet to see ${widget.type.name}",
                  ),
                )
              : ListView.separated(
                  controller: widget.scrollController,
                  itemCount: widget.isPaginateLoading
                      ? widget.list.length + 1
                      : widget.list.length,
                  separatorBuilder: (context, index) {
                    return Ink(
                      color: Colors.white,
                      child: const CustomDivider(),
                    );
                  },
                  itemBuilder: (context, index) {
                    if (index < widget.list.length) {
                      switch (widget.type) {
                        case ListType.pokemon:
                          return PookeeTile<Pokemon>(
                              pokemon: widget.list[index]);
                        case ListType.moves:
                          return MoveTileView<Move>(move: widget.list[index]);
                        case ListType.items:
                          return ItemTileView<Item>(item: widget.list[index]);
                        default:
                          return const Text("Null");
                      }
                    } else {
                      return const Center(child: CustomLoading());
                    }
                  }),
    );
  }
}
