import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/main_Menu.dart';
import 'user_login.dart';
import '../services/auth.dart';

//Root para melhor gerir mudanças entre login screen e homePage
class RootPage extends StatefulWidget{
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus{
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage>
{
  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();

    widget.auth.currentState().then((userID)
    {
      setState(() {
        if (userID == null)
          _authStatus = AuthStatus.notSignedIn;
        else
          _authStatus = AuthStatus.signedIn;
      });
    });
  }

  void _signedIn()
  {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut()
  {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {

    switch(_authStatus)
    {
      case AuthStatus.notSignedIn:
        {
          return new UserLogin(
              auth: widget.auth,
              onSignedIn: _signedIn,
          );
        }
      case AuthStatus.signedIn:
        {
          return new MainMenu(
            auth: widget.auth,
            onSignedOut: _signedOut,
          );
        }
    }
  }
}

