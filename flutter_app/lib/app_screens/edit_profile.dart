import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/services/database.dart';

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

  @override
  void initState()
  {
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
  }

  _submit()
  {
    _formKey.currentState.save();

    String _profileImageUrl = '';
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage('https://i.redd.it/dmdqlcdpjlwz.jpg'),
                  ),
                  FlatButton(
                    onPressed: () => print('change pic'),
                    child: Text(
                      'Change proflie image',
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
        ),
      )
    );
  }
}
