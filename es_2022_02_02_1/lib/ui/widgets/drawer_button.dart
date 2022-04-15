import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {}, // => MainScreen.controlMenu(),
      icon: const Icon(
        Icons.menu,
      ),
    );
  }
}
