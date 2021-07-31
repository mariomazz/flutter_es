import 'package:flutter/material.dart';
// Counter provider

class Counter with ChangeNotifier {
  int num = 21;

  int get counterNum => num;

  void increment() {
    num += 1;
    notifyListeners();
  }

  void resetCounter() {
    num = 0;
    notifyListeners();
  }
}
