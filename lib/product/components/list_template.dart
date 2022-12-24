import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pookeedex/core/constants/asset_const.dart';

import '../../core/constants/padding_const.dart';
import '../../core/enum/list_enum.dart';
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        AssetConst.lostConnection,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "You should connect internet to view ${widget.type.name}.",
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
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
                          return PookeeTile(pokemon: widget.list[index]);
                        case ListType.moves:
                          return MovesTile(move: widget.list[index]);
                        case ListType.items:
                          return ItemTile(item: widget.list[index]);
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
