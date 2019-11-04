import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/UserData.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import 'package:flutter_app/app_screens/homePage.dart';
import 'package:flutter_app/app_screens/user_profile.dart';


class MainMenu extends StatefulWidget {

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _currentTab = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: _pageController,
          children: <Widget>[
            HomePage(),
            UserProfile(userId: Provider.of<UserData>(context).currentUserId)
          ],
        onPageChanged: (int index) {
            setState(() {
              _currentTab = index;
            });
        },
      ),
      appBar: new AppBar(
        title: Text('Mingler', style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () => AuthService.logout(),
            icon: Icon(Icons.exit_to_app),
            label: Text('Logout'),
          )
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentTab,
        onTap: (int index) {
          setState(() {
            _currentTab = index;
          });
          _pageController.animateToPage(
              index,
              duration: Duration(microseconds: 200),
              curve: Curves.easeIn
          );
        },
        activeColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 32,),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, size: 32,)
          )
        ],
      ),
    );
  }
}