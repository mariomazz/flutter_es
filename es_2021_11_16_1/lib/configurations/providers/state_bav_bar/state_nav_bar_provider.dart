import 'package:flutter/material.dart';

class StateNavBarProvider extends ChangeNotifier {
  int index = 0;

  set setIndex(int index) {
    this.index = index;
  }

  get getIndex => index;
}
