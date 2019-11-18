import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Conference.dart';
import 'package:flutter_app/models/UserData.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConferenceEdit extends StatefulWidget {
  final Conference conf;

  ConferenceEdit({this.conf});

  @override
  _ConferenceEditState createState() => _ConferenceEditState();
}

class _ConferenceEditState extends State<ConferenceEdit> {

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _location = '';
  String _url = '';
  String _urlName = '';
  String _desc = '';
  File _eventImage;
  DateTime _dateTime;
  Map<String, String> _formData;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.conf != null) {
      _name = widget.conf.name;
      _location = widget.conf.address;
      _desc = widget.conf.descr;
      _dateTime = widget.conf.getDate;
      _formData = widget.conf.topics;
    }
    else{
      _formData = _initiateMap();
    }
  }

  Map<String, String> _initiateMap()
  {
    var myMap = new Map<String, String>();

    myMap['topic0'] = '';
    myMap['topic1'] = '';
    myMap['topic2'] = '';
    myMap['topic3'] = '';
    myMap['topic4'] = '';
    myMap['topic5'] = '';

    return myMap;
  }

  _dateToStamp()
  {
    return Timestamp.fromDate(_dateTime);
  }

  _handleImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      setState(() {
        _eventImage = imageFile;
      });
    }
  }

  _displayProfileImage(){
    if(_eventImage == null)
    {
      if(widget.conf == null || widget.conf.imageUrl.isEmpty)
      {
        return AssetImage('assets/images/event_placeholder.jpg');
      }
      else {
        return CachedNetworkImageProvider(widget.conf.imageUrl);
      }
    }
    else {
      return FileImage(_eventImage);
    }
  }
  
  _countTopics()
  {
    int cnt = 0;
    _formData.forEach((k,v) => v.trim().isEmpty
        ? null
        : cnt++);

    return cnt;
  }

  _submit() async {
    if (_formKey.currentState.validate() && _countTopics() > 2) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });


      String _eventImageUrl = '';


      if (_eventImage == null && widget.conf != null) {
        _eventImageUrl = widget.conf.imageUrl;
      } else {
        if (widget.conf != null) {
          _eventImageUrl = await Storage.uploadEventImage(
            widget.conf.imageUrl,
            _eventImage,
          );
        } else {
          _eventImageUrl = await Storage.uploadEventImage(
            "",
            _eventImage,
          );
        }
      }

      if(widget.conf != null) {
        Conference conf = Conference(
          eventId: widget.conf.eventId,
          ownerId: Provider.of<UserData>(context).currentUserId,
          name: _name,
          address: _location,
          descr: _desc,
          date: _dateToStamp(),
          urlName: _urlName,
          urlLink: _url,
          imageUrl: _eventImageUrl,
          topics: _formData
        );

        Database.updateConference(conf);
      }
      else{
        Conference conf = Conference(
          ownerId: Provider.of<UserData>(context).currentUserId,
          name: _name,
          address: _location,
          descr: _desc,
          date: _dateToStamp(),
          urlName: _urlName,
          urlLink: _url,
          imageUrl: _eventImageUrl,
          topics: _formData
        );

        Database.createConference(conf);
      }

      Navigator.pop(context);
    }
    else if (_countTopics() < 3)
    {
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text('Not enough topics!'),
              content: Text('Please select at least 3 topics.'),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                      'Close',
                  style: TextStyle(
                    color: Colors.red
                  ),
                  ),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Event',
          style: new TextStyle(
              fontSize: 16,
              color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            children: <Widget> [
              _isLoading
                  ? LinearProgressIndicator(
                  backgroundColor: Colors.blue[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue))
                  : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.cover,
                                image: _displayProfileImage(),
                              )),
                            ),
                          ),
                        ],
                      ),
                    Divider(
                      color: Colors.white,
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: _handleImageFromGallery,
                          child: Text(
                            'Change Conference image',
                            style: TextStyle(
                                color: Theme.of(context).accentColor, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                      height: 5,
                    ),
                    TextFormField(
                      initialValue: _name,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.image,
                            size: 30,
                          ),
                          labelText: 'Conference Name'),
                      validator: (input) => input.trim().length < 1
                          ? 'Please enter a valid name.'
                          : null,
                      onSaved: (input) => _name = input,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(_dateTime == null
                              ? 'Nothing has been picked yet'
                              : DateFormat('dd-MM-yyyy').format(_dateTime),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          RaisedButton(
                            child: Text('Choose a date'),
                            onPressed: () {
                              showDatePicker(
                                  context: context,
                                  initialDate:
                                  _dateTime == null ? DateTime.now() : _dateTime,
                                  firstDate: DateTime(2019),
                                  lastDate: DateTime(2030))
                                  .then((date) {
                                setState(() {
                                 if(date == null)
                                   _dateTime = DateTime.now();
                                 else
                                   _dateTime = date;
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      initialValue: _location,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.location_on,
                            size: 30,
                          ),
                          labelText: 'Enter Location'),
                      validator: (input) => input.trim().length < 1
                          ? 'Please enter a valid Location.'
                          : null,
                      onSaved: (input) => _location = input,
                    ),
                    Divider(
                      color: Colors.white,
                      height: 5,
                    ),
                    TextFormField(
                      initialValue: _url,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.alternate_email,
                            size: 30,
                          ),
                          labelText: 'URL:'),
                      validator: (input) => input.trim().length < 1
                          ? 'Please enter a valid url.'
                          : null,
                      onSaved: (input) => _url = input,
                    ),
                    Divider(
                      color: Colors.white,
                      height: 5,
                    ),
                    TextFormField(
                      initialValue: _urlName,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.web_asset,
                            size: 30,
                          ),
                          labelText: 'Enter Website Name (optional)'),
                      onSaved: (input) => _urlName = input,
                    ),
                    Divider(
                      color: Colors.white,
                      height: 5,
                    ),
                    TextFormField(
                      initialValue: _desc,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.book,
                            size: 30,
                          ),
                          labelText: 'Description'),
                      validator: (input) =>
                          input.trim().length > 300 ? 'Description max: 300 chars.' : null,
                      onSaved: (input) => _desc = input,
                    ),
                    Divider(
                      color: Colors.white,
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Select topics',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),
                            ),
                            Text(
                              '(min. 3, leave undesirables null)'
                            ),
                          ],
                        )
                      ],
                    ),
                    TextFormField(
                      initialValue: _formData['topic0'],
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        icon: Icon(Icons.filter_1),
                        labelText: 'Topic 1'
                      ),
                      validator: (input) =>
                        input.trim().length > 70 ? 'Topic max: 70 chars.' : null,
                      onSaved: (input) => _formData['topic0'] = input,
                    ),
                    TextFormField(
                      initialValue: _formData['topic1'],
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          icon: Icon(Icons.filter_2),
                          labelText: 'Topic 2'
                      ),
                      validator: (input) =>
                      input.trim().length > 70 ? 'Topic max: 70 chars.' : null,
                      onSaved: (input) => _formData['topic1'] = input,
                    ),
                    TextFormField(
                      initialValue: _formData['topic2'],
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          icon: Icon(Icons.filter_3),
                          labelText: 'Topic 3'
                      ),
                      validator: (input) =>
                      input.trim().length > 70 ? 'Topic max: 70 chars.' : null,
                      onSaved: (input) => _formData['topic2'] = input,
                    ),
                    TextFormField(
                      initialValue: _formData['topic3'],
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          icon: Icon(Icons.filter_4),
                          labelText: 'Topic 4'
                      ),
                      validator: (input) =>
                      input.trim().length > 70 ? 'Topic max: 70 chars.' : null,
                      onSaved: (input) => _formData['topic3'] = input,
                    ),
                    TextFormField(
                      initialValue: _formData['topic4'],
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          icon: Icon(Icons.filter_5),
                          labelText: 'Topic 5'
                      ),
                      validator: (input) =>
                      input.trim().length > 70 ? 'Topic max: 70 chars.' : null,
                      onSaved: (input) => _formData['topic4'] = input,
                    ),
                    TextFormField(
                      initialValue: _formData['topic5'],
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                          icon: Icon(Icons.filter_6),
                          labelText: 'Topic 6'
                      ),
                      validator: (input) =>
                      input.trim().length > 70 ? 'Topic max: 70 chars.' : null,
                      onSaved: (input) => _formData['topic5'] = input,
                    ),

                    Container(
                      margin: EdgeInsets.all(40),
                      height: 40,
                      width: 250,
                      child: RaisedButton(
                        onPressed: _submit,
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text(
                          'Save changes',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ],
          ),
        ),
    );
  }
}
