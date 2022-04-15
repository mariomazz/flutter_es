import 'package:flutter/material.dart';

class ScaffoldStateP {
  // singleton

  static final _instance = ScaffoldStateP();
  static ScaffoldStateP get get => _instance;

  // end singleton

  GlobalKey<ScaffoldMessengerState> get key => _messangerKey;
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
}
