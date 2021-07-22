import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  List<Widget>? actions;
  Color? color;
  Widget? leading;
  bool? automaticallyImplyLeading;

  MyAppbar(
      {Key? key,
      this.title,
      this.actions,
      this.color,
      this.leading,
      this.automaticallyImplyLeading})
      : super(key: key) {
    if (automaticallyImplyLeading == null) {
      automaticallyImplyLeading = true;
    }
  }
  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading!,
      leading: leading != null ? leading : null,
      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          : null,
    );
  }
}
