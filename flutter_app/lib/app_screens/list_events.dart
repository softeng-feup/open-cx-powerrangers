import 'package:flutter/material.dart';

class ListEvents extends StatefulWidget {
  @override
  _ListEventsState createState() => _ListEventsState();
}

class _ListEventsState extends State<ListEvents> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My Events', style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
          centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(

            )
          ],
        ),
      ),
    );
  }
}
