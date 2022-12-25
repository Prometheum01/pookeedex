import 'package:flutter/material.dart';

import 'package:pookeedex/features/screens/onboard_screen/view_model/onboard_view_model.dart';
import 'package:pookeedex/product/components/widgets.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends OnboardViewModel {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MainGradient(),
        Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () async {
                  await close();
                },
                splashColor: Colors.white,
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: Row(
            children: [
              IconButton(
                onPressed: () {
                  decreasePage();
                },
                splashColor: Colors.white,
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: contentList,
                ),
              ),
              IconButton(
                onPressed: () {
                  increasePage();
                },
                splashColor: Colors.white,
                icon: const Icon(
                  Icons.arrow_forward,
                ),
              )
            ],
          ),
          backgroundColor: Colors.white.withOpacity(0.8),
        ),
      ],
    );
  }
}
