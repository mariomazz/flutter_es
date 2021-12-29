import 'package:deo_demo/ui/widgets/custom_circular_proress_indicator.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoadingScreen extends StatelessWidget {
  LoadingScreen({Key key}) : super(key: key);
  Duration duration = Duration(milliseconds: 1000);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyCircularProgressIndicator(
          duration: duration,
          borderColor: Colors.blue,
        ),
      ),
    );
  }
}
