/* import 'package:deo_demo/core/providers/authentication/auth_provider.dart';
import 'package:deo_demo/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key key}) : super(key: key);
  static ValueKey keyPage = ValueKey('intro_page');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: Provider.of<AuthProvider>(context, listen: false)
          .checkIsAuth(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return HomePage(); // build APP
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('errore'),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
 */