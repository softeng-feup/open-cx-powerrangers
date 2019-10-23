import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/homePage.dart';
import 'package:flutter_app/app_screens/user_profile.dart';


class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  //TODO: Criar tipo de letra no inicio para nao repetir em cada Textfield

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Mingler'),
            centerTitle: true,
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