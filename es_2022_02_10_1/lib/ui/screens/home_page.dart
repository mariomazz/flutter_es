import 'package:es_2022_02_10_1/ui/widget/neumorphic_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: const SizedBox.expand(
        child: Center(
          child: NeumorphicButton(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  'Giada Mazzarelli',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  'Sito Web Mauro Mazzarelli',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
