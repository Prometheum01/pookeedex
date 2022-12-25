import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../connectivity/network_connectivity.dart';

class NetworkProvider extends ChangeNotifier {
  InternetConnectionStatus? _connection;

  listenConnection() async {
    NetworkConnectivity().handleNetworkConnectivity((result) async {
      _connection = result;
      notifyListeners();
    });
  }

  InternetConnectionStatus? get connection => _connection;
}
