import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TopicsEdit extends StatefulWidget {
  final String eventId;


  TopicsEdit({this.eventId});

  @override
  _TopicsEditState createState() => _TopicsEditState();
}

class _TopicsEditState extends State<TopicsEdit> {
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: new AppBar(
       title: Text(
         'Edit Event Topics',
         style: new TextStyle(
             fontSize: 16,
             fontWeight: FontWeight.bold,
             color: Colors.white
         ),
       ),
       centerTitle: true,
     ),
    body: SingleChildScrollView(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Select some topics for the event',
                            style: TextStyle(
                                fontSize: 16
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(40),
                height: 40,
                width: 250,
                child: RaisedButton(
                  onPressed: () => print('...'),
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text(
                    'Save changes',
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),

        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => print('Butoum top')

          ),
        ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


   );


  }

}