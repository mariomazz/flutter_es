import 'package:es_2022_02_02_1/ui/pages/main_screen.dart';
import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => MainScreen.controlMenu(),
      icon: const Icon(
        Icons.menu,
      ),
    );
  }
}
