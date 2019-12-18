import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/match.dart';
import 'package:flutter_app/models/Conference.dart';
import 'package:flutter_app/models/UserData.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget
{
  static final String id = 'homePage_screen';

  final String uid;

  HomePage({this.uid});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  String userid;
  String dropdownevent;
  List<String> allconferences = List();
  static List<String> conferencenames = List();
  Future<QuerySnapshot> _events;


  _getUid(BuildContext context)
  {
    return Provider.of<UserData>(context).currentUserId;
  }

  @override
  void initState() {
    super.initState();
    //userid = _getUid(context);
    _events = Database.getEvents(widget.uid);

  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getConferences() async{
    List<DocumentSnapshot> docs = List();
    for(int i = 0; i < allconferences.length ;i++){
      docs.add(await eventRef.document(allconferences[i]).get());

    }
    return docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _events,
        builder: (context, snapshot){
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else{
            if(snapshot == null){
              return Center(
                child: Text(
                    'You aren\'t in any event! You need to join a conference before you can use the matching functionality'
                ),
              );
            }
            else{
              for(int i = 0; i < snapshot.data.documents.length;i++){
                allconferences.add(snapshot.data.documents[i].documentID);
              }
              return FutureBuilder(
                future: Future.wait([getConferences()]),
                builder: (context, AsyncSnapshot snap2){
                  if(!snap2.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else{
                    Conference conf;
                    var exists = false;
                    for(int i = 0; i < snap2.data[0].length ;i++){
                      exists = false;
                     conf = Conference.fromDoc(snap2.data[0][i]);
                     for(int j = 0; j < conferencenames.length; j++){
                       if(conferencenames[j] == conf.name){
                         exists = true;
                         break;
                       }
                     }
                     if(exists != true){
                       conferencenames.add(conf.name);
                     }
                    }

                    return Scaffold(
                      body: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                          DropdownButton<String>(
                          value: dropdownevent,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownevent = newValue;
                              });
                            },
                            items:conferencenames
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                            Container(
                              width: 200,
                              height: 200,
                              child: Column(
                                children: <Widget>[
                                  SizedBox( // Register button
                                    height: 20,
                                  ),
                                  ButtonTheme(
                                    minWidth: double.infinity,
                                    height: 100,
                                    child: RaisedButton(
                                      onPressed: () =>  (Navigator.push( context,
                                          MaterialPageRoute(builder: (context) =>Match(userId: widget.uid,eventName: dropdownevent,)))),
                                      textColor: Colors.white,
                                      color: Colors.green,
                                      child: Text("✓", textScaleFactor: 5),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              );
            }
          }
        },
      ),
    );
  }
}