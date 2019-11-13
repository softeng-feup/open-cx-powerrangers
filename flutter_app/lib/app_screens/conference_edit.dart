import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ConferenceEdit extends StatefulWidget {
  final String eventId;

  ConferenceEdit({this.eventId});

  @override
  _ConferenceEditState createState() => _ConferenceEditState();
}

class _ConferenceEditState extends State<ConferenceEdit> {
  bool isJoined = false;
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _location = '';
  String _url = '';
  String _urlName = '';
  String _desc = '';
  File _profileImage;
  DateTime _dateTime;

  _logout()
  {
    AuthService.logout();
    Navigator.pop(context);
  }

  _handleImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    if(imageFile != null)
    {
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mingler', style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
          centerTitle: true,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: _logout,
              icon: Icon(Icons.exit_to_app),
              label: Text('Logout'),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
               child: Column(
                  children: <Widget>[
                       Form(
                        key: _formKey,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/images/event_placeholder.jpg'),
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),

                      ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () => print('...'),
                          child: Text(
                            'Change Conference image',
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize:  16
                            ),

                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        initialValue: _name,
                        style: TextStyle(
                            fontSize: 18
                        ),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.image,
                              size: 30,
                            ),
                            labelText: 'Conference Name'
                        ),
                        validator: (input) => input.trim().length < 1
                            ? 'Please enter a valid name.'
                            : null,
                        onSaved: (input) => _name = input,
                      ),

                    ),
                    Text(_dateTime == null ? 'Nothing has been picked yet' : DateFormat('yyyy-MM-dd').format(_dateTime)),
                    RaisedButton(
                      child: Text('Choose a date'),
                      onPressed: () {
                        showDatePicker(
                            context: context,
                            initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                            firstDate: DateTime(2019),
                            lastDate: DateTime(2021)
                        ).then((date) {
                          setState(() {
                            _dateTime = date;
                          });
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        initialValue: _location,
                        style: TextStyle(
                            fontSize: 18
                        ),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.location_on,
                              size: 30,
                            ),
                            labelText: 'Enter Location'
                        ),
                        validator: (input) => input.trim().length < 1
                            ? 'Please enter a valid Location.'
                            : null,
                        onSaved: (input) => _location = input,
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        initialValue: _url,
                        style: TextStyle(
                            fontSize: 18
                        ),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.alternate_email,
                              size: 30,
                            ),
                            labelText: 'URL:'
                        ),
                        validator: (input) => input.trim().length < 1
                            ? 'Please enter a valid Location.'
                            : null,
                        onSaved: (input) => _url = input,
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        initialValue: _urlName,
                        style: TextStyle(
                            fontSize: 18
                        ),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.web_asset,
                              size: 30,
                            ),
                            labelText: 'Enter Location'
                        ),
                        validator: (input) => input.trim().length < 1
                            ? 'Please enter a valid Location.'
                            : null,
                        onSaved: (input) => _urlName = input,
                      ),

                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        initialValue: _desc,
                        style: TextStyle(
                            fontSize: 18
                        ),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.book,
                              size: 30,
                            ),
                            labelText: 'Bio'
                        ),
                        validator: (input) => input.trim().length > 300
                            ? 'Bio max: 300 chars.'
                            : null,
                        onSaved: (input) => _desc = input,
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

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Topics',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:  20,
                                      fontWeight: FontWeight.bold
                                  ),

                                ),
                              ],
                            ),

                            Column(
                              children: <Widget>[
                                FlatButton.icon(onPressed:() => print('.....'), icon: Icon(Icons.edit), label: Text('Edit'))
                              ],
                            ),
                          ],

                      ),
                    ),

                  ],
                ),

          ),
        ) ,
    );
  }

}
