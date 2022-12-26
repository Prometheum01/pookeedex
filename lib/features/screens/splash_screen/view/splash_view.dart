import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/constants/asset_const.dart';
import 'package:pookeedex/product/components/widgets.dart';

import '../../../../core/constants/padding_const.dart';
import '../view_model/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends SplashViewModel {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          const MainGradient(),
          Container(
            color: Colors.white.withOpacity(0.8),
          ),
          Positioned(
            bottom: context.dynamicHeight(0.025),
            left: context.dynamicWidth(0.25),
            child: Image.asset(
              AssetConst.fromPmx,
              width: context.dynamicWidth(0.5),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Padding(
                padding: const PaddingConst.mediumAll(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomLoading(),
                    Text(
                      "\nWe are getting data from The Cinnabar Lab...",
                      textAlign: TextAlign.center,
                      style: context.textTheme.headline5,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
