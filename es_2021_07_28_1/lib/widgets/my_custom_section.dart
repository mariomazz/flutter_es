import 'package:es_2021_07_28_1/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class MyCustomSection extends StatelessWidget {
  MyCustomSection({Key? key}) : super(key: key);

  MediaQueryData? dataLayout;

  @override
  Widget build(BuildContext context) {
    dataLayout = MediaQuery.of(context);

    return AspectRatio(
      aspectRatio: dataLayout!.size.width / dataLayout!.size.height,
      child: InkWell(
        onTap: () => context.read<Counter>().increment(),
        child: Container(
          width: 100,
          height: 100,
          child: Center(
            child: Text(
              '${context.read<Counter>().counterNum}',
              style: TextStyle(
                fontSize: ((30 * dataLayout!.size.width) / 426 < 55)
                    ? (30 * dataLayout!.size.width) / 426
                    : 55,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
