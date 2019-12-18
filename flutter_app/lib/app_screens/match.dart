import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/root.dart';
import 'package:flutter_app/app_screens/wait_match.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/utils/constants.dart';


class Match extends StatefulWidget {
  final String userId;
  final String eventName;


  Match({this.userId,this.eventName});

  @override
  _MatchState createState() => _MatchState();
}

var currentContext;


class _MatchState extends State<Match> {

  Future<QuerySnapshot> _match;

  /*Future<DocumentSnapshot> findRandomMatch(userId) async{

    DocumentSnapshot ds = await usersRef.document(userId).get();
    //print(ds.data);
    return ds;
  }*/

  static var uid1;
  static var uid2;

  @override
  void initState() {
    super.initState();
    uid1= widget.userId;
    _match = Database.findMatch2Pair(widget.eventName, widget.userId);
  }

  static var currentContext;

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return Scaffold(
      body: FutureBuilder(
        future: _match,
        builder: ( context , snapshot){
          if(!snapshot.hasData){
            return Center(
                child: CircularProgressIndicator()
            );
          }
          else {
            //var rnd = new Random();
            //var min = 0, max = 3;
            //var index = min + rnd.nextInt(max - min);
            //print(index);
            //print(snapshot.data.documents.length);
            User user = User.fromDoc(snapshot.data.documents[0]);
            uid2 = user.uid;
            //print(uid2);
            //print(uid1);
            return Scaffold(

              appBar: AppBar(
                title: Text("Match"),
                centerTitle: true,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        user.name,
                        textAlign: TextAlign.center,
                        textScaleFactor: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: CircleAvatar(
                              minRadius: 50.0,
                              backgroundColor: Colors.grey,
                              backgroundImage:
                              user.profileImageUrl.isEmpty
                                  ? AssetImage('assets/images/user_placeholder.jpg')
                                  : CachedNetworkImageProvider(user.profileImageUrl),
                          ),
                          width: 100,
                        )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Container(
                          child: Text(
                            "wants to mingle with you",
                            textAlign: TextAlign.center,
                            textScaleFactor: 2,
                          ),
                          width: 400,
                        )
                        ],
                      ),

                      Container(
                        child: acceptButton,
                        width: 200,
                        height: 200,
                      ),

                      Container(
                        child: rejectButton,
                        width: 200,
                        height: 200,
                      ),

                    ],
                  ),
                ),
              ),
            );
          }
        },

      ),
    );
  }


  final acceptButton = Container(
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
                MaterialPageRoute(builder: (currentContext) =>WaitMatch(user1: uid1,user2: uid2,)))),
            textColor: Colors.white,
            color: Colors.green,
            child: Text("✓", textScaleFactor: 5),
          ),
        ),
      ],
      )
  );

  final rejectButton = Container(
      child: Column(children: <Widget>[
        SizedBox( // Register button
          height: 20,
        ),
        ButtonTheme(
          minWidth: double.infinity,
          height: 100,
          child: RaisedButton(
            onPressed: () =>
            (Navigator.push(currentContext,
                MaterialPageRoute(builder: (currentContext) => RootPage()))),
            textColor: Colors.white,
            color: Colors.red,
            child: Text("X", textScaleFactor: 5),
          ),
        ),
      ],
      )
  );
}



