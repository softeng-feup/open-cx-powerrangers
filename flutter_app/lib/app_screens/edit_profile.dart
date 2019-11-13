import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/services/storage.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final User user;

  EditProfile({this.user});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _bio = '';
  File _profileImage;
  bool _isLoading = false;

  @override
  void initState()
  {
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
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

  _displayProfileImage(){
    if(_profileImage == null)
    {
      if(widget.user.profileImageUrl.isEmpty)
      {
        return AssetImage('assets/images/user_placeholder.jpg');
      }
      else {
        return CachedNetworkImageProvider(widget.user.profileImageUrl);
      }
    }
    else {
      return FileImage(_profileImage);
    }
  }

  _submit() async
  {
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    String _profileImageUrl = '';

    if(_profileImage == null)
    {
      _profileImageUrl = widget.user.profileImageUrl;
    }
    else {
      _profileImageUrl = await Storage.uploadUserProfileImage(
          widget.user.profileImageUrl,
          _profileImage);
    }

    User user = User(
      uid: widget.user.uid,
      name: _name,
      bio: _bio,
      profileImageUrl: _profileImageUrl,
    );

    Database.updateUser(user);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          'Edit Profile',
          style: new TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: <Widget>[
            _isLoading
            ? LinearProgressIndicator(
              backgroundColor: Colors.blue[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue))
            : SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      backgroundImage: _displayProfileImage(),
                    ),
                    FlatButton(
                      onPressed: _handleImageFromGallery,
                      child: Text(
                        'Change profile image',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize:  16
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: _name,
                      style: TextStyle(
                        fontSize: 18
                      ),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            size: 30,
                          ),
                        labelText: 'Name'
                      ),
                      validator: (input) => input.trim().length < 1
                          ? 'Please enter a valid name.'
                          : null,
                      onSaved: (input) => _name = input,
                    ),
                    TextFormField(
                      initialValue: _bio,
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
                      validator: (input) => input.trim().length > 150
                          ? 'Bio max: 150 chars.'
                          : null,
                      onSaved: (input) => _bio = input,
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
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
