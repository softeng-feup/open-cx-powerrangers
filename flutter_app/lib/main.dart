import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix1;

import 'package:provider/provider.dart';
import 'models/User.dart';
import 'services/auth.dart';
import 'app_screens/root.dart';
import 'package:flutter_app/app_screens/notification.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NotificationHandler(),
      ),
    );
  }
}

