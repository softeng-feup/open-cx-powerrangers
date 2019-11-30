

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/homePage.dart';
import 'package:flutter_app/models/Match.dart';
import 'package:flutter_app/services/findMatch.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:meta/meta.dart';


class WaitMatch extends StatefulWidget{
  final String user1;
  final String user2;
  final String event;

  WaitMatch({this.user1,this.user2,this.event});

  @override
  _WaitMatchState createState() => _WaitMatchState();

}

class _WaitMatchState extends State<WaitMatch> {

  var inserted = 0;
  var initTime;
  var newTime;
  var timeoutTime;

  @override
  void initState() {
    super.initState();
    initTime =  new DateTime.now();
    timeoutTime = initTime.add(new Duration(seconds: 60));
  }

  Future waitForResponse() async{
    if(inserted == 0){
      matchesRef.add({
        'requester': widget.user1,
        'receiver' :widget.user2,
        'event'    :widget.event,
        'accepted' :false,
        'completed':false,
        'rating': 0.0
      });
    }

    QuerySnapshot query = await matchesRef.where("requester",isEqualTo: widget.user1).where("receiver",isEqualTo: widget.user2).where("event",isEqualTo: widget.event).getDocuments();

    return query.documents;
  }

  var currentContext;

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return Scaffold(
      body: FutureBuilder(
        future: waitForResponse(),
        builder: ( _,snapshot){
          newTime = DateTime.now();
          if(!snapshot.hasData && newTime.isBefore(timeoutTime)  == true){// or match is not accepted and timeout not reached
            return Center(
                child: CircularProgressIndicator()
            );
          }

          Match match = Match.fromDoc(snapshot.data);

          if(match.accepted == false){
              return Center(
                  child: CircularProgressIndicator()
              );
          }
          else if(newTime.isAfter(timeoutTime)  == true){// timeout
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
                                    MaterialPageRoute(builder: (currentContext) => HomePage()))),
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