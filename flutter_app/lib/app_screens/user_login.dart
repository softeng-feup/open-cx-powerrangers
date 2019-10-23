import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/homePage.dart';
import 'package:flutter_app/app_screens/main_Menu.dart';
import 'package:flutter_app/app_screens/user_register.dart';
import 'user_profile.dart';


class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {//TODO: Criar tipo de letra no inicio para nao repetir em cada Textfield

  @override
  Widget build(BuildContext context) {
    currentContext = context;
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
                  emailRow,
                  passwordRow,
                  loginButtonRow,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final emailRow = Container(
      child: Column(children: <Widget>[
        SizedBox( //caixa do username
          height: 30,
        ),
        TextField(
          autofocus: false,
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          controller: emailEditingContrller,
          decoration: InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                      width: 1,
                      color: Colors.green,
                      style: BorderStyle.solid))),
        ),
      ],)
  );


  final passwordRow = Container(
      child: Column(children: <Widget>[
        SizedBox( //caixa da password
          height: 30,
        ),
        TextField(
          autofocus: false,
          obscureText: true,
          keyboardType: TextInputType.text,
          controller: passwordEditingContrller,
          decoration: InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: Colors.green,
                      style: BorderStyle.solid))),
        ),
      ],
      )
  );

  final loginButtonRow = Container(
      child: Column(children: <Widget>[
        SizedBox(
          height: 50,
        ),
        ButtonTheme(
          //elevation: 4,
          //color: Colors.green,
          minWidth: double.infinity,
          child: MaterialButton(
            onPressed: () => {
              //check if user is valid
              Navigator.push(
                currentContext,
                MaterialPageRoute(builder: (currentContext) => MainMenu()),
              )
            },
            textColor: Colors.white,
            color: Colors.green,
            height: 50,
            child: Text("Login"),
          ),
        ),
      ],
      )
  );
}