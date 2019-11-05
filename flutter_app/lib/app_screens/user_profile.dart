import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/edit_profile.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/utils/constants.dart';


class UserProfile extends StatefulWidget {
  final String userId;

  UserProfile({this.userId});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: usersRef.document(widget.userId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData)
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          User user = User.fromDoc(snapshot.data);

        return ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                      user.profileImageUrl.isEmpty
                          ? AssetImage('assets/images/user_placeholder.jpg')
                          : CachedNetworkImageProvider(user.profileImageUrl),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              user.name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 150,
                          child: FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => EditProfile(user: user,))),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.bio,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    height: 80.0,
                    child: Text(
                      'Interests',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}