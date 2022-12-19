import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

typedef NetworkCallBack = void Function(InternetConnectionStatus status);

abstract class NetworkConnectivityInterface {
  Future<InternetConnectionStatus> checkNetworkConnectivity();
  void handleNetworkConnectivity(NetworkCallBack onChange);
  void dispose();
}
