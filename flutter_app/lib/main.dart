import 'package:flutter/material.dart';

import 'app_screens/user_login.dart';
import 'app_screens/user_profile.dart';
import 'app_screens/user_register.dart';

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
            bottom: TabBar( //temporary: to be used for homescreen/profile/matches
              tabs: [
                Tab(text: 'Login'),
                Tab(text: 'Register')
              ],
            ),
            title: Text('Mingler', textAlign: TextAlign.center,),
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

