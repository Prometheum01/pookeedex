import 'package:flutter/material.dart';
import 'package:pookeedex/product/components/widgets.dart';

import '../view_model/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends SplashViewModel {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MainGradient(),
        Scaffold(
          backgroundColor: Colors.white.withOpacity(0.8),
          body: const Center(
            child: CustomLoading(),
          ),
        ),
      ],
    );
  }
}
