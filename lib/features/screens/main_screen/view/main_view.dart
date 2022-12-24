import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/features/screens/favorite_screen/view/favorite_view.dart';
import 'package:pookeedex/features/screens/home_screen/view/home_view.dart';
import 'package:pookeedex/features/screens/items_screen/view/items_view.dart';
import 'package:pookeedex/features/screens/main_screen/view_model/main_view_model.dart';
import 'package:pookeedex/features/screens/moves_screen/view/moves_view.dart';
import 'package:pookeedex/product/components/widgets.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends MainViewModel {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MainGradient(),
        Container(
          color: Colors.white.withOpacity(0.8),
        ),
        isLoading
            ? const Center(
                child: CustomLoading(),
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  toolbarHeight: context.dynamicHeight(0.15),
                  title: screenIndex == 3
                      ? const FavoriteRow()
                      : const SearchBar(),
                ),
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    const MainGradient(height: 4),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          HomeView(),
                          MovesView(),
                          ItemsView(),
                          FavoriteView(),
                        ],
                      ),
                    ),
                    const MainGradient(height: 4),
                  ],
                ),
                bottomNavigationBar: const CustomBottomNavigation(),
              )
      ],
    );
  }
}
