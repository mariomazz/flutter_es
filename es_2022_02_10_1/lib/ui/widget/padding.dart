import 'package:flutter/material.dart';

class PaddingCS extends StatelessWidget {
  const PaddingCS({Key? key, required this.child, this.padding = 8.0})
      : super(key: key);
  final Widget child;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}