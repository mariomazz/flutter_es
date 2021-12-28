import 'package:flutter/material.dart';

class StackEmpty extends StatelessWidget {
  const StackEmpty({Key key}) : super(key: key);
  static ValueKey keyPage = ValueKey('stack_empty');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
