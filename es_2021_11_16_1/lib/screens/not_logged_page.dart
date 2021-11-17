import 'package:es_2021_11_16_1/configurations/providers/authentication/authentication_provider.dart';
import 'package:es_2021_11_16_1/widgets/custom_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotLoggedPage extends StatelessWidget {
  NotLoggedPage({Key? key}) : super(key: key);
  static ValueKey keyPage = ValueKey('not_logged_page');

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      page: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('login'),
              IconButton(
                onPressed: () =>
                    Provider.of<AuthProvider>(context, listen: false)
                        .setAuth(context, true),
                icon: Icon(
                  Icons.login,
                  size: 35.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
