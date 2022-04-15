import 'package:flutter/material.dart';
import 'core/scaffold.state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: ScaffoldStateP.get.key,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _show() {
    ScaffoldStateP.get.key.currentState
        ?.showSnackBar(const SnackBar(content: Text('Processing Data')));
  }

  double heightContainer = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('hey Mario $heightContainer'),
            TextButton(
              onPressed: () => _show(),
              child: const Text('Elevated Size'),
            ),
            StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    Container(
                      color: Colors.amberAccent,
                      height: heightContainer,
                      width: double.infinity,
                    ),
                    TextButton(
                      onPressed: () => setState(() =>
                          heightContainer = heightContainer == 100 ? 200 : 100),
                      child: const Text('Elevated Size'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
