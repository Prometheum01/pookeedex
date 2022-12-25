import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'i_network_connectivity.dart';

class NetworkConnectivity extends NetworkConnectivityInterface {
  late final InternetConnectionChecker _checker;

  StreamSubscription<InternetConnectionStatus>? _subscription;

  NetworkConnectivity() {
    _checker = InternetConnectionChecker();
  }

  @override
  Future<InternetConnectionStatus> checkNetworkConnectivity() async {
    if (await _checker.hasConnection) {
      return InternetConnectionStatus.connected;
    } else {
      print('No internet :( Reason:');
      return InternetConnectionStatus.disconnected;
    }
  }

  @override
  void handleNetworkConnectivity(NetworkCallBack onChange) {
    _subscription = _checker.onStatusChange.listen((event) {
      onChange.call(event);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
  }
}
