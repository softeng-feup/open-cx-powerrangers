import 'package:flutter/material.dart';
import 'user_profile.dart';

class UserRegister extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {

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
                        labelText: "Full name: ",
                        hintText: "FullName",
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


                  SizedBox( // caixa do email
                    height: 30,
                  ),
                  TextField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Email: ",
                        hintText: "Email",
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


                  SizedBox( //caixa do username
                    height: 30,
                  ),
                  TextField(
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                        labelText: "Username: ",
                        hintText: "Username",
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
                  SizedBox( //caixa da password
                    height: 30,
                  ),
                  TextField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password: ",
                        hintText: "Password",
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
                  SizedBox( //caixa da password repetida
                    height: 30,
                  ),
                  TextField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password(again): ",
                        hintText: "PasswordRepeated",
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
                  SizedBox( // button de register
                    height: 20,
                  ),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: MaterialButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserProfile()),
                        )
                      },
                      textColor: Colors.white,
                      color: Colors.green,
                      height: 50,
                      child: Text("Register"),
                    ),
                  ),
                  SizedBox( // button de goBack
                    height: 20,
                  ),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: MaterialButton(
                      onPressed: () => {
                        Navigator.pop(
                            context
                        ),
                      },
                      textColor: Colors.white,
                      color: Colors.red,
                      height: 50,
                      child: Text("Go Back"),
                    ),
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