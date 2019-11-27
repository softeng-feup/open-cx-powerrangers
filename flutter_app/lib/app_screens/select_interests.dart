import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/database.dart';

class SelectInterests extends StatefulWidget {
  final Map<dynamic, dynamic> topicMap;
  final String eventId;
  final String userId;

  SelectInterests({this.topicMap, this.eventId, this.userId});

  @override
  _SelectInterestsState createState() => _SelectInterestsState();
}

class _SelectInterestsState extends State<SelectInterests> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Select topics', style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
          centerTitle: true,
        ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Submit", style: TextStyle(fontSize: 20),),
              onPressed: getItems,
              color: Colors.pink,
              textColor: Colors.white,
              splashColor: Colors.pinkAccent,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            ),
            Expanded(
              child: ListView(
                children:
                  widget.topicMap.keys.map(
                      (dynamic key){
                        return CheckboxListTile(
                          title: Text(key),
                          value: widget.topicMap[key],
                          activeColor: Colors.pink,
                          checkColor: Colors.white,
                          onChanged: (bool value){
                            setState(() {
                              widget.topicMap[key] = value;
                            });
                          },
                        );
                    }).toList(),
                  ),
              ),
          ]),
      )
    );
  }

  getItems(){

    Database.followEvent(
        currentUserId: widget.userId,
        eventId: widget.eventId,
        topics: widget.topicMap);

    Navigator.pop(context);
  }
}
