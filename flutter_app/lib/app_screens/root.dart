import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/homePage.dart';
import 'package:flutter_app/app_screens/main_Menu.dart';
import 'package:flutter_app/app_screens/user_register.dart';
import 'package:flutter_app/models/UserData.dart';
import 'package:provider/provider.dart';
import 'user_login.dart';


//Root para melhor gerir mudanças entre login screen e homePage
class RootPage extends StatelessWidget{

  Widget _getScreenId() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Provider.of<UserData>(context).currentUserId = snapshot.data.uid;
          return MainMenu();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => UserData(),
      child: MaterialApp(
        title: 'Mingler',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
            color: Colors.black,
          ),
        ),
        home: _getScreenId(),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomePage.id: (context) => HomePage(),
        },
      ),
    );
  }

}
