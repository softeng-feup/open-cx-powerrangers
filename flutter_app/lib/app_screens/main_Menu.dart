import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'package:flutter_app/app_screens/homePage.dart';
import 'package:flutter_app/app_screens/user_profile.dart';


class MainMenu extends StatefulWidget {
  MainMenu({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  //TODO: Criar tipo de letra no inicio para nao repetir em cada Textfield

  void _signedOut() async
  {
    try{
      await widget.auth.signOut();
      widget.onSignedOut();
    }
    catch(e)
    {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: new AppBar(
            title: Text('Mingler', style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
            centerTitle: true,
            actions: <Widget>[
              new FlatButton(
                  onPressed: _signedOut,
                  child: new Text('Logout', style: new TextStyle(fontSize: 17, color: Colors.white))
              )
            ],
            bottom: TabBar(
              tabs: [
                Tab(text: 'Home Page'),
                Tab(text: 'Profile'),
              ],
            ),
      ),
          body: TabBarView(
            children: [
              homePage(),
              UserProfile()
            ],
          ),
        ),
      ),
    );
  }
}