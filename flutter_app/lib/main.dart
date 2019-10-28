import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/User.dart';
import 'services/auth.dart';
import 'app_screens/root.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value(
      value: Auth().user,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(auth: new Auth(),),
      ),
    );
  }
}

