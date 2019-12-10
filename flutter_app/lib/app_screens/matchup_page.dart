

import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/root.dart';
import 'package:flutter_app/models/Match.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class Matchup extends StatefulWidget {

  final Match match;

  Matchup({this.match});


  @override
  _MatchupState  createState() => _MatchupState();

}

var currentContext;
var m;

class _MatchupState extends State<Matchup>{

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    m = widget.match;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Matchup"
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              cancelMatch
            ],
          ),
        ),
      ),
    );
  }


  final cancelMatch = new Container(
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        ButtonTheme(
          minWidth: double.infinity,
          height: 100,
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.red,
            onPressed: () => (Navigator.push(currentContext, MaterialPageRoute(builder: (currentContext) => RootPage()))),
            child: Text(
              "Cancel",
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    ),
  );



  /*final finishedMatch = new Container(
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        ButtonTheme(
          minWidth: double.infinity,
          height: 100,
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.red,
            child: Text(
              "Cancel",
              textAlign: TextAlign.center,
            ),
        )
      ],
    ),
  );*/


}