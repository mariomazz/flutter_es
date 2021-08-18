import 'package:flutter/material.dart';

class DialogBox {
  static show({required BuildContext context, required Widget widget}) {
    showDialog(
      context: context,
      builder: (context) {
        return widget;
      },
    );
  }
}
