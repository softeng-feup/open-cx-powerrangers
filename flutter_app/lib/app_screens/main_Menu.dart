import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/conference_page.dart';
import 'package:flutter_app/app_screens/list_events.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/models/UserData.dart';
import 'package:flutter_app/utils/constants.dart';
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

  _getUid(BuildContext context)
  {
     return Provider.of<UserData>(context).currentUserId;
  }

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
            UserProfile(userId: _getUid(context))
          ],
        onPageChanged: (int index) {
            setState(() {
              _currentTab = index;
            });
        },
      ),
      appBar: AppBar(
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
      drawer: FutureBuilder(
        future: usersRef.document(_getUid(context)).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          User user = User.fromDoc(snapshot.data);

          return Drawer(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountEmail: Text(user.email),
                  accountName: Text(user.name),
                  currentAccountPicture: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                    user.profileImageUrl.isEmpty
                        ? AssetImage('assets/images/user_placeholder.jpg')
                        : CachedNetworkImageProvider(user.profileImageUrl),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                ListTile(
                  leading: Icon(Icons.search),
                  title: Text('Search Event'),
                  onTap: () => print('searching'),
                ),
                ListTile(
                  leading: Icon(Icons.book),
                  title: Text('My Events'),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ConferencePage())),
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text('Match history'),
                  onTap: () => print('historiating'),
                ),
                Divider(),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: ListTile(
                      leading: Icon(Icons.help),
                      title: Text('About us'),
                      onTap: () => print('aboutating'),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.grey[200],
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