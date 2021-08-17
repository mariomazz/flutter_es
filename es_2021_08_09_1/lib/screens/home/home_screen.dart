import 'package:flutter/material.dart';
import 'package:myapp/widgets/various-widgets/custom_dialog_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home page'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.access_alarm,
                size: 26.0,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Flex(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        direction: Axis.vertical,
        children: [
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text(
                    "Buy now".toUpperCase(),
                    style: TextStyle(fontSize: 14),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(17),
                    ),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  onPressed: () => dialogBox(context),
                ),
              ),
            ),
          ),
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: Text(
                    "page posts".toUpperCase(),
                    style: TextStyle(fontSize: 14),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(17),
                    ),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  onPressed: () => dialogBox(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void dialogBox(BuildContext context) {
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
  }
}
