import 'package:pookeedex/core/services/provider/cache_provider.dart';
import 'package:pookeedex/core/services/provider/pookee_provider.dart';
import 'package:provider/provider.dart';

import 'main_screen_provider.dart';

class ProviderManager {
  ProviderManager._();
  static List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider(
      create: (context) => PookeeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => MainScreenProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => CacheProvider(),
    ),
  ];
}
