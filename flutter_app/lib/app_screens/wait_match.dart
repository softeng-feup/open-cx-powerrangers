

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


class WaitMatch extends StatefulWidget{
  final String user1;
  final String user2;

  WaitMatch({this.user1,this.user2});

  @override
  _WaitMatchState createState() => _WaitMatchState();

}

class _WaitMatchState extends State<WaitMatch> {
  
  Timer timer;

  var inserted = 0;
  var initTime;
  var newTime;
  var timeoutTime;

  @override
  void initState() {
    super.initState();
    initTime =  new DateTime.now();
    timeoutTime = initTime.add(new Duration(seconds: 60));
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        newTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future waitForResponse() async{
    if(inserted == 0){
      matchesRef.add({
        'requester': widget.user1,
        'receiver' :widget.user2,
        'event'    :"",
        'accepted' :false,
        'completed':false,
        'rating': 0.0
      });
      inserted = 1;
    }

    QuerySnapshot query = await matchesRef.where("requester",isEqualTo: widget.user1).where("receiver",isEqualTo: widget.user2).limit(1).getDocuments();



    return query.documents[0];
  }

  var currentContext;

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return Scaffold(
      body: FutureBuilder(
        future: waitForResponse(),
        builder: ( _,snapshot){
          //newTime = DateTime.now();
          //print(newTime);
          //print(timeoutTime);
          if(!snapshot.hasData && newTime.isBefore(timeoutTime)  == true){// or match is not accepted and timeout not reached
            //print("yeet");
            //newTime = DateTime.now();
            //print(newTime);
            return Center(
                child: CircularProgressIndicator()
            );
          }
          //print("yeet2");
          Match match = Match.fromDoc(snapshot.data);

          if(match.accepted == false && newTime.isBefore(timeoutTime) == true){
            //newTime = DateTime.now();
            //print(newTime);
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
                                        MaterialPageRoute(builder: (currentContext) => HomePage()))), // TODO: Meetup page
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