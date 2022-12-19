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
            ? Center(
                child: Column(
                children: const [
                  CustomLoading(),
                  Text("Please wait first loading take some time.")
                ],
              ))
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  toolbarHeight: context.dynamicHeight(0.15),
                  title: const SearchBar(),
                ),
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    const MainGradient(),
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
                    const MainGradient(),
                  ],
                ),
                bottomNavigationBar: const CustomBottomNavigation(),
              )
      ],
    );
  }
}
