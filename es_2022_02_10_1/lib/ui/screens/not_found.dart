import 'package:flutter/material.dart';
import '../widget/title.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TitleCS(
          data: "404 NOT FOUND",
        ),
      ),
    );
  }
}
