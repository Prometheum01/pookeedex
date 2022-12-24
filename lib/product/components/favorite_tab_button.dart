import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../core/constants/color_const.dart';
import '../../core/constants/padding_const.dart';
import '../../core/services/provider/main_screen_provider.dart';

class FavoriteTabButton extends StatelessWidget {
  const FavoriteTabButton({super.key, required this.id, required this.text});

  final int id;

  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.read<MainScreenProvider>().currentFavoriteScreenIndex !=
            id) {
          context.read<MainScreenProvider>().changeFavoriteScreen(id);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(360),
          ),
          color:
              context.watch<MainScreenProvider>().currentFavoriteScreenIndex ==
                      id
                  ? Colors.white.withOpacity(0.8)
                  : null,
          gradient:
              context.watch<MainScreenProvider>().currentFavoriteScreenIndex ==
                      id
                  ? const LinearGradient(
                      colors: ColorConst.mainGradientColors,
                    )
                  : null,
          boxShadow:
              context.watch<MainScreenProvider>().currentFavoriteScreenIndex ==
                      id
                  ? [
                      BoxShadow(
                        color: ColorConst.textColor.withOpacity(0.7),
                        blurRadius: 10,
                      ),
                    ]
                  : null,
        ),
        child: Padding(
          padding: const PaddingConst.smallAll(),
          child: Center(
            child: Text(
              text,
              style: context.textTheme.headline6?.copyWith(
                  color: context
                              .watch<MainScreenProvider>()
                              .currentFavoriteScreenIndex ==
                          id
                      ? Colors.white
                      : ColorConst.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
