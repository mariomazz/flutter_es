import 'package:es_2021_07_28_1/providers/providers.dart';
import 'package:es_2021_07_28_1/widgets/card_number_center.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var dataLayout = MediaQuery.of(context);
    return ChangeNotifierProvider<Counter>(
      create: (context) => Counter(),
      child: Consumer<Counter>(
        builder: (context, data, widget) => Scaffold(
          body: createBody(context, dataLayout),
        ),
      ),
    );
  }

  Widget createBody(BuildContext context, MediaQueryData dataLayout) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          backgroundColor: const Color.fromRGBO(176, 208, 211, 1),
          actions: [
            GestureDetector(
              onTap: () => context.read<Counter>().resetCounter(),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Icon(
                  Icons.refresh,
                  size: ((30 * dataLayout.size.width) / 426 <= 50)
                      ? (30 * dataLayout.size.width) / 426
                      : 50,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          title: Text(
            'la mia app bar',
            style: GoogleFonts.notoSans(
              fontStyle: FontStyle.normal,
              color: Colors.black,
              fontSize: ((30 * dataLayout.size.width) / 426 < 52)
                  ? (30 * dataLayout.size.width) / 426
                  : 52,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return CardNumberCenter(
                number: context.read<Counter>().counterNum,
                actionCard: () => context.read<Counter>().increment(),
                toShare: () => Share.share(
                    'check out my website ${context.read<Counter>().counterNum} https://example.com'),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    );
  }
}
