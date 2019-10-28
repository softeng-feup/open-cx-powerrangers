import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.blue;
  final String title;
  final AppBar appBar;
  final List<Widget> widgets;
  final Widget bottom;


  const BaseAppBar({Key key, this.title, this.appBar, this.widgets, this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: backgroundColor,
      actions: widgets,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}