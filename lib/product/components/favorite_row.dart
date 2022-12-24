import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'favorite_tab_button.dart';

class FavoriteRow extends StatelessWidget {
  const FavoriteRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Favorite',
          style: context.textTheme.headline4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Flexible(child: FavoriteTabButton(id: 0, text: 'Pokemon')),
            Flexible(child: FavoriteTabButton(id: 1, text: 'Moves')),
            Flexible(child: FavoriteTabButton(id: 2, text: 'Items')),
          ],
        ),
      ],
    );
  }
}
