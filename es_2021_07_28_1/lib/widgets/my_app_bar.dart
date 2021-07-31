import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  List<Widget>? actions;
  Color? color;
  Widget? leading;
  bool? automaticallyImplyLeading;
  Widget? title;

  MyAppbar(
      {Key? key,
      this.title,
      this.actions,
      this.color,
      this.leading,
      this.automaticallyImplyLeading})
      : super(key: key) {
    automaticallyImplyLeading == null ? automaticallyImplyLeading = true : null;

    title == null ? title = const Text('') : null;
  }
  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    var dataLayout = MediaQuery.of(context);

    return AppBar(
      backgroundColor: color,
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading!,
      leading: leading != null ? leading : null,
      title: title,
    );
  }
}
