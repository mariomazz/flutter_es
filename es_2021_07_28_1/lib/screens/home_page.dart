import 'package:es_2021_07_28_1/providers/providers.dart';
import 'package:es_2021_07_28_1/widgets/my_custom_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  MediaQueryData? dataLayout;

  @override
  Widget build(BuildContext context) {
    dataLayout = MediaQuery.of(context);
    return ChangeNotifierProvider<Counter>(
      create: (context) => Counter(),
      child: Consumer<Counter>(
        builder: (context, data, widget) => Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'la mia app bar',
                style: TextStyle(
                  fontSize: ((30 * dataLayout!.size.width) / 426 < 52)
                      ? (30 * dataLayout!.size.width) / 426
                      : 52,
                ),
              ),
            ),
          ),
          body: ListView.builder(
            itemBuilder: (context, index) => MyCustomSection(),
            itemCount: 57,
          ),
        ),
      ),
    );
  }
}
