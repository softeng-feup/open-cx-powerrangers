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

  var match;

  @override
  void initState() {
    super.initState();

    FindMatch()
        .findRandomMatch()
        .then((QuerySnapshot docs) {
          if(docs.documents.isNotEmpty){
          match = docs.documents[1].data;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    /*return Scaffold(
      body: FutureBuilder(
        future: usersRef.document(widget.userId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          User user = User.fromDoc(snapshot.data);
          return Scaffold(

            appBar: AppBar(
              title: Text('Match'),
              centerTitle: true,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      user.name
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Container(
                        child: CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                          user.profileImageUrl.isEmpty
                              ? AssetImage('assets/images/user_placeholder.jpg')
                              : CachedNetworkImageProvider(user.profileImageUrl),
                        ),
                        width: 400,
                      )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Container(
                        child: textColumn,
                        width: 400,
                      )
                      ],
                    ),
                    Row(
                        children: [Container(
                          child: acceptButton,
                          width: 200,
                          height: 200,
                        ),
                          Container(
                            child: rejectButton,
                            width: 200,
                            height: 200,
                          )
                        ]
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
    ); */
    return Text(
      match['email']
    );
  }
  final textColumn = Container( //Match generic text
      child: Column(children: <Widget>[
        TextField(
          maxLines: 5,
          enabled: false,
          autofocus: false,
          obscureText: false,
          decoration: InputDecoration(
            labelText: "wants to Mingle\n with you!",
            hintText: "Rating",
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 35,
            ),
          ),
        ),
      ],
      )
  );

  final acceptButton = Container(
      child: Column(children: <Widget>[
        SizedBox( // Register button
          height: 20,
        ),
        ButtonTheme(
          minWidth: double.infinity,
          height: 100,
          child: RaisedButton(
            shape: CircleBorder(
              side: BorderSide(color: Colors.green),),
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
            shape: CircleBorder(
              side: BorderSide(color: Colors.red)),
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



