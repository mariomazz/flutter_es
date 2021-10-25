import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff778da9),
      body: Center(
        child: Draggable(
          feedback: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: Color(0xff778da9),
              boxShadow: [
                BoxShadow(
                  blurRadius: 24,
                  color: Color(0xff657890),
                  offset: Offset(
                    12,
                    12,
                  ),
                ),
                BoxShadow(
                  blurRadius: 24,
                  color: Color(0xff89a2c2),
                  offset: Offset(
                    -12,
                    -12,
                  ),
                ),
              ],
              gradient: LinearGradient(
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff6b7f98), Color(0xff7f97b5)],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  91,
                ),
              ),
            ),
          ),
          childWhenDragging: Container(),
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: Color(0xff778da9),
              boxShadow: [
                BoxShadow(
                  blurRadius: 24,
                  color: Color(0xff657890),
                  offset: Offset(
                    12,
                    12,
                  ),
                ),
                BoxShadow(
                  blurRadius: 24,
                  color: Color(0xff89a2c2),
                  offset: Offset(
                    -12,
                    -12,
                  ),
                ),
              ],
              gradient: LinearGradient(
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff7f97b5), Color(0xff6b7f98)],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  91,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 


/* class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
} */
