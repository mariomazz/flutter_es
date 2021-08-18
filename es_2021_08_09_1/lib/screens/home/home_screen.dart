import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widgets/shared/custom_dialog_box.dart';
import 'package:myapp/widgets/shared/show_bottom_scheet.dart';
import 'package:myapp/widgets/shared/show_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home page'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => BottomScheet.show(
                context: context,
                widget: Center(
                  child: Icon(
                    Icons.access_alarm,
                    size: 45.0,
                  ),
                ),
              ),
              child: Icon(
                Icons.access_alarm,
                size: 26.0,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text(
                    "page users".toUpperCase(),
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
                  onPressed: () => Navigator.of(context).pushNamed('/users'),
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
                  onPressed: () => Navigator.of(context).pushNamed('/posts'),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedIconButton(
        size: 50,
        onPressed: () => DialogBox.show(
          context: context,
          widget: CustomDialogBox(
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
          ),
        ),
        duration: const Duration(milliseconds: 500),
        splashColor: Colors.transparent,
        icons: <AnimatedIconItem>[
          AnimatedIconItem(
            icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
          ),
          AnimatedIconItem(
            icon: Icon(Icons.close, color: Theme.of(context).primaryColor),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
