import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService extends ChangeNotifier {
  Connectivity connectivity = Connectivity();

  ConnectivityStatus connectionStatus;

  ConnectivityStatus get getConnectionStatus => connectionStatus;

  ConnectivityService() {
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatus = _getStatusFromResult(result);
      notifyListeners();
    });
  }

  // Convert from the third part enum to our own enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }

  Future<bool> checkConnectivity() async {
    final ConnectivityResult result = await connectivity.checkConnectivity();
    final ConnectivityStatus status = _getStatusFromResult(result);

    if (status != ConnectivityStatus.Offline) {
      return true;
    }
    return false;
  }
}

enum ConnectivityStatus {
  WiFi,
  Cellular,
  Offline,
}
