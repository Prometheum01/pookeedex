import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pookeedex/core/services/provider/main_screen_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentIndex = context.watch<MainScreenProvider>().currentScreenIndex;
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withOpacity(0.3),
      backgroundColor: Colors.transparent,
      elevation: 0,
      onTap: (value) {
        context.read<MainScreenProvider>().changeScreen(value);
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svg/ic_pokemon.svg",
            color: currentIndex == 0
                ? Colors.black
                : Colors.black.withOpacity(0.3),
          ),
          label: "Pokemon",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svg/ic_move.svg",
            color: currentIndex == 1
                ? Colors.black
                : Colors.black.withOpacity(0.3),
          ),
          label: "Moves",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svg/ic_item.svg",
            color: currentIndex == 2
                ? Colors.black
                : Colors.black.withOpacity(0.3),
          ),
          label: "Items",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            color: currentIndex == 3
                ? Colors.black
                : Colors.black.withOpacity(0.3),
          ),
          label: "Favorite",
        ),
      ],
    );
  }
}
