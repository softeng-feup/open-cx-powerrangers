import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/BaseAppBar.dart';

import 'app_screens/user_login.dart';
import 'app_screens/user_profile.dart';
import 'app_screens/user_register.dart';
import 'app_screens/homePage.dart';
import 'app_screens/main_Menu.dart';
import 'app_screens/match.dart';
import 'app_screens/auth.dart';
import 'app_screens/root.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: Scaffold(
          body: RootPage(auth: new Auth(),),
          ),
        );
  }
}

