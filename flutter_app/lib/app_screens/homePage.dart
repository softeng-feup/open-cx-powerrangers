import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/match.dart';
import 'package:flutter_app/models/UserData.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget
{
  static final String id = 'homePage_screen';

  _getUid(BuildContext context)
  {
    return Provider.of<UserData>(context).currentUserId;
  }

  static var uid;

  @override
  Widget build(BuildContext context)
  {
    uid = _getUid(context);
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
              MaterialPageRoute(builder: (_) => Match(userId: uid,))),
        )
      ),
    );
  }
}