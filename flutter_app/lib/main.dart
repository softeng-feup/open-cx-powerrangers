import 'package:flutter/material.dart';

import 'app_screens/user_login.dart';
import 'app_screens/user_profile.dart';
import 'app_screens/user_register.dart';
import 'app_screens/homePage.dart';
import 'app_screens/main_Menu.dart';
import 'app_screens/match.dart';

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
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Login'),
                Tab(text: 'Register'),
              ],
            ),
            title: Text('Mingler', textAlign: TextAlign.right,),
          ),
          body: TabBarView(
            children: [
              UserLogin(),
              UserRegister(),
            ],
          ),
        ),
      ),
    );
  }
}

