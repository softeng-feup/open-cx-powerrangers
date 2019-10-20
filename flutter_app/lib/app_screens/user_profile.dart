import 'package:flutter/material.dart';


class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox( //caixa do nome
                    height: 30,
                  ),
                  TextField(
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                        labelText: "Name",
                        hintText: "Name",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 0,
                                color: Colors.green,
                                style: BorderStyle.solid))),
                  ),


                  SizedBox( // caixa da Password
                    height: 30,
                  ),
                  TextField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Description",
                        hintText: "Description",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue,
                                style: BorderStyle.solid))),
                  ),


                  SizedBox( //caixa dos interesses
                    height: 30,
                  ),
                  TextField(
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                        labelText: "Interests",
                        hintText: "Interests",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                width: 0,
                                color: Colors.green,
                                style: BorderStyle.solid))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}