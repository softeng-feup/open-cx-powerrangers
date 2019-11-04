import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget
{
  static final String id = 'homePage_screen';

  @override
  Widget build(BuildContext context)
  {
    return new Scaffold(
      body: new Container(
        child: new Text('Your feed is empty :(')
      ),
    );
  }
}