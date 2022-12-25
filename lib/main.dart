import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/constants/color_const.dart';
import 'package:pookeedex/core/services/cache/hive_manager.dart';
import 'package:pookeedex/core/services/navigator/navigator_service.dart';
import 'package:pookeedex/core/services/provider/main_screen_provider.dart';
import 'package:provider/provider.dart';

import 'core/services/provider/cache_provider.dart';
import 'core/services/provider/pookee_provider.dart';

Future<void> main() async {
  await HiveManager().initDB();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PookeeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CacheProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pookeedex',
      theme: ThemeData(
        textTheme: TextTheme(
          headline3: context.textTheme.headline3?.copyWith(
            color: ColorConst.textColor,
          ),
          headline4: context.textTheme.headline4?.copyWith(
            color: ColorConst.textColor,
          ),
          headline5: context.textTheme.headline6?.copyWith(
            color: ColorConst.textColor,
          ),
          headline6: context.textTheme.headline6?.copyWith(
            color: ColorConst.textColor,
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
      ),
      builder: (context, child) {
        if (child != null) {
          return Column(
            children: [
              Expanded(child: child),
              Container(
                color: Colors.redAccent,
                width: double.infinity,
                height: context.watch<MainScreenProvider>().connection ==
                        InternetConnectionStatus.connected
                    ? 0
                    : null,
                child: Center(
                  child: Text(
                    "There is no Internet Connection",
                    style: context.textTheme.headline5
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
              Container(
                color: Colors.blueAccent,
                width: double.infinity,
                height:
                    context.watch<MainScreenProvider>().cacheLoading ? null : 0,
                child: Center(
                  child: Text(
                    "Data caching for offline mode. Please don't close app.",
                    textAlign: TextAlign.center,
                    style: context.textTheme.headline5
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        }
        //TODO:ErrorWidget
        return Text("Error");
      },
      initialRoute: NavigatorKeys.splash.path,
      routes: NavigatorService.navigatorKeys,
    );
  }
}
