import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Conference.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/utils/constants.dart';

class ListEvents extends StatefulWidget {
  final String uid;

  ListEvents({this.uid});

  @override
  _ListEventsState createState() => _ListEventsState();
}

class _ListEventsState extends State<ListEvents> {
  Future<QuerySnapshot> _events;

  _buildEventCard(Conference conf)
  {
    return Text(
      conf.name,
    );
  }

  @override
  void initState() {
    super.initState();
    _events = Database.getEvents(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My Events', style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
          centerTitle: true,
      ),
      body: FutureBuilder(
        future: _events,
        builder: (context, snapshot){
          if(!snapshot.hasData || snapshot == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.data.documents.length == 0)
          {
            return Center(
              child: Text(
                  'You aren\'t in any event!'
              ),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index){
                String eventId = snapshot.data.documents[index].documentID;
                print(eventId);
                return FutureBuilder(
                  future: eventRef.document(eventId).get(),
                  builder: (context, snap2){
                    if(!snap2.hasData || snap2 == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    DocumentSnapshot doc = snap2.data;
                    Conference conf = Conference.fromDoc(doc);
                    return _buildEventCard(conf);
                  },
                );
              }
          );
        },
      )
    );
  }


}
