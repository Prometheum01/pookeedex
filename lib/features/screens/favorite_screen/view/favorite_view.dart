import 'package:flutter/material.dart';
import 'package:pookeedex/core/enum/list_enum.dart';
import 'package:pookeedex/features/screens/favorite_screen/view_model/favorite_view_model.dart';
import 'package:pookeedex/product/components/widgets.dart';

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
      body: Column(
        children: [
          Expanded(
            child: PageView(
              children: [
                FavoriteListTemplate(list: pookeeList, type: ListType.pokemon),
                FavoriteListTemplate(list: moveList, type: ListType.moves),
                FavoriteListTemplate(list: itemList, type: ListType.items),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteListTemplate extends StatelessWidget {
  const FavoriteListTemplate({
    Key? key,
    required this.list,
    required this.type,
  }) : super(key: key);

  final List list;

  final ListType type;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Ink(
        color: Colors.white,
        child: const CustomDivider(),
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        switch (type) {
          case ListType.pokemon:
            return PookeeTile(pokemon: list[index]);
          case ListType.moves:
            return MovesTile(move: list[index]);
          case ListType.items:
            return ItemTile(item: list[index]);
          default:
            return const Text("Null");
        }
      },
    );
  }
}
