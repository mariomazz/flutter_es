import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService extends ChangeNotifier {
  Connectivity connectivity = Connectivity();

  ConnectivityStatus connectionStatus;

  bool hasConnection = false;

  ConnectivityStatus get getConnectionStatus => connectionStatus;

  bool get getHasConnection => hasConnection;

  ConnectivityService.inizialize() {
    connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      connectionStatus = _getStatusFromResult(result);

      if (connectionStatus != ConnectivityStatus.Offline) {
        hasConnection = await checkConnection();
      } else {
        hasConnection = false;
      }

      notifyListeners();
    });
  }

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

  Future<bool> checkConnection() async {
    bool hasConnection = false;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    return hasConnection;
  }

  Future<bool> connectivityIsEmpty(Connectivity connectivity) async {
    return await connectivity.onConnectivityChanged.isEmpty ? true : false;
  }
}

enum ConnectivityStatus {
  WiFi,
  Cellular,
  Offline,
}
