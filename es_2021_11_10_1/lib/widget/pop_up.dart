import 'package:flutter/material.dart';

class PopUp extends ModalRoute<void> {
  PopUp({required this.bodyPopUp});

  Widget bodyPopUp;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.white.withOpacity(0.5);

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    final dataLayout = MediaQuery.of(context);
    return Center(
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  40 / 375 * dataLayout.size.width,
                ),
              ),
              border: Border.all(
                width: 2,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                bodyPopUp,
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Conferma',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 35,
                )
              ],
            ),
          ),
        ),
      Positioned(
        top: 22,
        right: 90,
        child: Container(   decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  40 / 375 * dataLayout.size.width,
                ),
              ),
              border: Border.all(
                width: 2,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:8),
              child: Text('#125846' , style:TextStyle( fontSize:20 , fontWeight:FontWeight.bold , color: Theme.of(context).secondaryHeaderColor)),
            ),),
      ),
      

      ]),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
