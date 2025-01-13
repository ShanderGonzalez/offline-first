import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  ConnectivityService() {
    _checkInitialConnection();
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _isConnected = results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi);
      notifyListeners();
    });
  }

  Future<void> _checkInitialConnection() async {
    final results = await _connectivity.checkConnectivity();
    _isConnected = results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi);
    notifyListeners();
  }
}
