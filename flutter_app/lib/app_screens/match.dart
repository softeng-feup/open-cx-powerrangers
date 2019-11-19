import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/root.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:flutter_app/services/findMatch.dart';

class Match extends StatefulWidget {
  final String userId;


  Match({this.userId});

  @override
  _MatchState createState() => _MatchState();
}

var currentContext;


class _MatchState extends State<Match> {

  Future findRandomMatch(userId) async{

    QuerySnapshot query = await usersRef.where("uid",isGreaterThan: userId).getDocuments();

    return query.documents;
  }

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return Scaffold(
      body: FutureBuilder(
        future: findRandomMatch(widget.userId),
        builder: ( _, snapshot){
          if(!snapshot.hasData){
            return Center(
                child: CircularProgressIndicator()
            );
          }
          else{
            var rnd = new Random();
            var min = 0, max = 3;
            var index = min + rnd.nextInt(max - min);
            User user = User.fromDoc(snapshot.data[index]);

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
                MaterialPageRoute(builder: (currentContext) => RootPage()))),
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



