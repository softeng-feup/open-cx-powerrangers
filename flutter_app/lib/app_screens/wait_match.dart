

import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/homePage.dart';
import 'package:flutter_app/app_screens/root.dart';
import 'package:flutter_app/models/Match.dart';
import 'package:flutter_app/services/findMatch.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:meta/meta.dart';
import 'package:flutter_app/services/database.dart';

import 'matchup_page.dart';


class WaitMatch extends StatefulWidget{
  final String user1;
  final String user2;

  WaitMatch({this.user1,this.user2});

  @override
  _WaitMatchState createState() => _WaitMatchState();

}



class _WaitMatchState extends State<WaitMatch> {
  
  Timer timer;

  int inserted;
  var initTime;
  var newTime;
  var timeoutTime;

  Match match;
  Match m;
  var matchid;

  @override
  void initState() {
    super.initState();
    inserted = 0;
    initTime =  new DateTime.now();
    timeoutTime = initTime.add(new Duration(seconds: 60));
    newTime = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        newTime = DateTime.now();
        inserted++;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future waitForResponse() async{
    if(inserted == 0){
      match = Match(
        requester: widget.user1,
        receiver: widget.user2,
        event: "",
        rating: 0,
        accepted: true,
        completed: false
      );
      matchid = await Database().addMatch(match);
    }

    if(matchid == null){
      return null;
    }
    else{
      DocumentSnapshot snap = await matchesRef.document(matchid).get();

      return snap;
    }
  }

  var currentContext;

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return Scaffold(
      body: FutureBuilder(
        future: waitForResponse(),
        builder: ( _,snapshot){

          //print(snapshot.data['requester']);
          if(!snapshot.hasData && newTime.isBefore(timeoutTime)  == true){// or match is not accepted and timeout not reached

            return Center(
                child: CircularProgressIndicator()
            );
          }

          match = Match.fromDoc(snapshot.data);

          if(match.accepted == false && newTime.isBefore(timeoutTime) == true){

              return Center(
                  child: CircularProgressIndicator()
              );
          }
          if(newTime.isAfter(timeoutTime)){// timeout
            return Scaffold(
                appBar: AppBar(
                    title: Text("Mingler"),
                    centerTitle: true,
                ),
                body: Container(
                  child: Container(
                      child: Column(children: <Widget>[
                          SizedBox( // Register button
                              height: 20,
                          ),
                          ButtonTheme(
                              minWidth: double.infinity,
                              height: 100,
                              child: RaisedButton(
                                onPressed: () =>
                                  (Navigator.push( currentContext,
                                    MaterialPageRoute(builder: (currentContext) => RootPage()))),
                                    textColor: Colors.white,
                                    color: Colors.green,
                              child: Text("Error: Go back to Home Page", textScaleFactor: 5),
                              ),
                          ),
                      ],
                      )
                  ),
                ),
            );

          }
          else{
            return Scaffold(
              appBar: AppBar(
                title: Text("Mingler"),
                centerTitle: true,
              ),
              body: Container(
                  child: Container(
                      child: Column(children: <Widget>[
                            SizedBox( // Register button
                              height: 20,
                            ),
                            ButtonTheme(
                              minWidth: double.infinity,
                              height: 100,
                                  child: RaisedButton(
                                      onPressed: () =>
                                      (Navigator.push( currentContext,
                                        MaterialPageRoute(builder: (currentContext) => Matchup(match: match,)))),
                                        textColor: Colors.white,
                                        color: Colors.green,
                                        child: Text("Go to Meetup", textScaleFactor: 5),
                                  ),
                            ),
                      ],
                    )
                  ),
              ),
            );
          }
        },
      ),
    );
  }
}