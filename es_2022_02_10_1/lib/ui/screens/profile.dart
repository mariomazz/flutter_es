import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widget/padding.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox.expand(
        child: Column(
          children: [
            PaddingCS(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Chat Bot - Profile",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(width: 15),
                  Icon(Icons.android)
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                context.go("/", extra: {"mario": "ciao mario"});
              },
              child: const Icon(Icons.arrow_circle_right),
            ),
          ],
        ),
      ),
    );
  }
}
