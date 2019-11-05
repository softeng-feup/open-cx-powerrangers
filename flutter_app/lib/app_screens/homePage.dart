import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/match.dart' as prefix0;

class HomePage extends StatelessWidget
{
  static final String id = 'homePage_screen';

  @override
  Widget build(BuildContext context)
  {
    return new Scaffold(
      body: new Container(
        child: RaisedButton(
          color: Colors.blue,
          child:
            Text(
              'Match',
              style: TextStyle(
                fontSize: 18
              ),
            ),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => prefix0.Match())),
        )
      ),
    );
  }
}