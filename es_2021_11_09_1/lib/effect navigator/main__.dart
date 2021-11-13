/* import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFaed1e6, color),
      ),
      home: Navigator(
        pages: [
          MaterialPage(
            key: ValueKey('home_page'),
            child: HomePage2(),
          )
        ],
        onPopPage: (route, result) => route.didPop(result),
      ),
    );
  }
}

// navigator 2.0
class HomePage2 extends StatelessWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('home page'),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text('home page'),
      ),
    );
  }
}

class ProfilePage2 extends StatelessWidget {
  const ProfilePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile page'),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: TextButton(
          onPressed: () => Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, _, __) => HomePage(),
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) =>
                  SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: const Offset(0, 0),
                ).animate(animation),
                child: child,
              ),
            ),
          ),
          child: Text('home page'),
        ),
      ),
    );
  }
}

//navigator 2.0

// navigator 1.0
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('home page'),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox.expand(
        child: GestureDetector(
          onPanUpdate: (update) {
            int sensitivity = 5;
            if (update.delta.dx < -sensitivity) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, _, __) => ProfilePage(),
                  transitionsBuilder: (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child,
                  ) =>
                      SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: const Offset(0, 0),
                    ).animate(animation),
                    child: child,
                  ),
                ),
              );
            }
          },
          child: TextButton(
            onPressed: () => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, _, __) => ProfilePage(),
                transitionsBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child,
                ) =>
                    SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: const Offset(0, 0),
                  ).animate(animation),
                  child: child,
                ),
              ),
            ),
            child: Text('profile page'),
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile page'),
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: SizedBox.expand(
        child: GestureDetector(
          onPanUpdate: (update) {
            int sensitivity = 5;
            if (update.delta.dx > sensitivity) {
              Navigator.pop(context);
            }
          },
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('home page'),
          ),
        ),
      ),
    );
  }
}
 */