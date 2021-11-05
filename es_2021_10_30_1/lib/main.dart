import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OverlayExample(),
    );
  }
}

class OverlayExample extends StatefulWidget {
  @override
  State<OverlayExample> createState() => _OverlayExampleState();
}

class _OverlayExampleState extends State<OverlayExample> {
  bool bottomPosition = false;
  bool topPosition = false;
  bool visibility = true;

  showOverlay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context)!;

    OverlayEntry _overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: CircleAvatar(
          radius: 50.0,
          backgroundColor: Colors.red,
          child: Icon(
            Icons.ac_unit_outlined,
            size: 50,
          ),
        ),
      ),
    );
    overlayState.insert(_overlayEntry);

    await Future.delayed(Duration(seconds: 2));

    _overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Overlay Example"),
        actions: <Widget>[
          GestureDetector(
            onTap: () => setState(() {
              visibility = !visibility;
            }),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.notifications),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() {
              topPosition = !topPosition;
            }),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.notifications),
            ),
          )
        ],
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.yellow,
          ),
          Visibility(
            visible: visibility,
            child: AnimatedPositioned(
              top: topPosition
                  ? MediaQuery.of(context).size.height - 200
                  : MediaQuery.of(context).size.height / 2.5,
              right: 0,
              left: 0,
              bottom: 0,
              duration: Duration(milliseconds: 1000),
              child: SizedBox.expand(
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    int sensitivity = 5;
                    if (details.delta.dy > sensitivity)
                      setState(() {
                        topPosition = true;
                      });
                    else if (details.delta.dy < -sensitivity)
                      setState(() {
                        topPosition = false;
                      });
                  },
                  child: Opacity(
                    opacity: 0.7,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.ac_unit_outlined,
                            size: 50,
                          ),
                          onPressed: () => setState(() {
                            showOverlay(context);
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
