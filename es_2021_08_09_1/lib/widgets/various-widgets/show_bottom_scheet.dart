import 'package:flutter/material.dart';

class BottomScheet {
  BottomScheet.show({required BuildContext context, required Widget widget}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          child: widget,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        );
      },
    );
  }
}
