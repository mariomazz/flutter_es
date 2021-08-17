import 'package:flutter/material.dart';
import 'package:myapp/widgets/various-widgets/custom_dialog_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home page'),
      ),
      body: Flex(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        direction: Axis.vertical,
        children: [
          Container(
            child: Center(
              child: Text(
                'home page',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pushNamed('/users'),
                    child: Text('Page USERS')),
              ),
            ),
          ),
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pushNamed('/posts'),
                    child: Text('Page POSTS')),
              ),
            ),
          ),
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return CustomDialogBox(
                          title: "Crea segnalazione",
                          descriptions:
                              "Puoi scegliere di segnalare un problema sul posto o farlo in differita",
                          primaryButtonTitle: "Segnala users",
                          primaryButtonDidTapHandler: () {
                            Navigator.of(context).pushNamed('/users');
                          },
                          secondaryButtonTitle: "Segnala posts",
                          secondaryButtonDidTapHandler: () {
                            Navigator.of(context).pushNamed('/posts');
                          },
                        );
                      },
                    );
                  },
                  child: Text('Dialog box'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
