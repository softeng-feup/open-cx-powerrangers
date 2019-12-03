import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Attendee.dart';
import 'package:flutter_app/models/Conference.dart';
import 'package:flutter_app/services/database.dart';

class ListAttendees extends StatefulWidget {
  final Conference conf;

  ListAttendees({this.conf});

  @override
  _ListAttendeesState createState() => _ListAttendeesState();
}

class _ListAttendeesState extends State<ListAttendees> {
  int atCnt = 0;
  List<DocumentSnapshot> _attendees;

  @override
  void initState() {
    super.initState();
    _setupFollowerCount();
   _setupAttendees();
  }

  _setupFollowerCount() async {
    int userFollowerCnt = await Database.numFollowers(widget.conf.eventId);

    setState(() {
      atCnt = userFollowerCnt;
    });
  }

  _setupAttendees() async{
    List<DocumentSnapshot> docs = await Database.getAttendees(widget.conf.eventId);

    setState(() {
      _attendees = docs;
    });
  }

  _buildAttendeeTile(Attendee attendee)
  {
    return ListTile(
      title: Text(attendee.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
        'Attendees',
        style: new TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: atCnt == 0
        ? Center(
        child: Text(
            'Your event has no attendees!'
        ),
      )
          : ListView.builder(
          itemCount: _attendees.length,
          itemBuilder: (BuildContext context, int index){
            Attendee attendee = Attendee.fromDoc(_attendees[index]);
            return _buildAttendeeTile(attendee);
          }
        ),
    );
  }
}
