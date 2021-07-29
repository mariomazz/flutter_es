import 'package:es_2021_07_28_1/providers/providers.dart';
import 'package:es_2021_07_28_1/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCustomSection extends StatelessWidget {
  MyCustomSection({Key? key}) : super(key: key);

  MediaQueryData? dataLayout;

  @override
  Widget build(BuildContext context) {
    dataLayout = MediaQuery.of(context);
    return AspectRatio(
      aspectRatio: dataLayout!.size.width / (dataLayout!.size.height / 2),
      child: InkWell(
        onTap: () => context.read<Counter>().increment(),
        child: Center(
          child: Text(
            '${context.read<Counter>().counterNum}',
            style: TextStyle(
              fontSize: ((30 * dataLayout!.size.width) / 426 < 65)
                  ? (30 * dataLayout!.size.width) / 426
                  : 65,
            ),
          ),
        ),
      ),
    );
  }
}
