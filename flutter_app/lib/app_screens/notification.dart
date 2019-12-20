
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/homePage.dart';
import 'package:flutter_app/app_screens/root.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:flutter_app/services/findMatch.dart';
import 'package:flutter_app/services/auth.dart';

class NotificationHandler extends StatefulWidget{
  @override
  createState() => _NotificationHandlerState();
}

class _NotificationHandlerState extends State<NotificationHandler>{
  final Firestore _db= Firestore.instance;
  final FirebaseMessaging _fcm=FirebaseMessaging();

  @override
  void initState(){
    super.initState();
    _saveDeviceToken();
    _fcm.configure(
      onMessage:(Map<String, dynamic> message) async{
        print("onMessage: $message");
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
          content: ListTile(
            title: Text(message['notification']['title']),
            subtitle: Text(message['notification']['body']),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
       );


        /*
        final snackbar =SnackBar(
          content: Text(message['notification']['title']),
          action: SnackBarAction(
            label: 'Go',
                onPressed:()=>HomePage(),
          ),
        );
        Scaffold.of(context).showSnackBar(snackbar);*/
      }
    );
  }


  _saveDeviceToken() async {
    // Get the current user
    FirebaseUser user = await AuthService().getCurrentUser();

    // Get the token for this device
    String fcmToken = await  _fcm.getToken();
    _fcm.getToken().then((token){print(token);});

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('users')
          .document(user.uid)
          .collection('tokens')
          .document(fcmToken);

      await tokens.setData({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RootPage();
  }
}

