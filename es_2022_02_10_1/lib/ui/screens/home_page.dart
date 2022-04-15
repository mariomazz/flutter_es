import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widget/chip.dart';
import '../widget/padding.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _chips =
        List<Widget>.generate(10, (index) => const ChipCS());
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          children: [
            PaddingCS(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Chat Bot",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(width: 15),
                  Icon(Icons.android)
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _chips.length,
                itemBuilder: (context, index) =>
                    PaddingCS(child: _chips.elementAt(index)),
              ),
            ),
            TextButton(
              onPressed: () {
                context.go("/profile", extra: {"mario": "ciao mario"});
              },
              child: const Icon(Icons.arrow_circle_right),
            ),
          ],
        ),
      ),
    );
  }
}
