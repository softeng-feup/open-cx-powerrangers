import 'package:flutter/material.dart';
import 'user_profile.dart';

class UserRegister extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

TextEditingController emailEditingContrller = TextEditingController();
TextEditingController passwordEditingContrller = TextEditingController();
var currentContext;

class _UserRegisterState extends State<UserRegister> {//TODO: Criar tipo de letra no inicio para nao repetir em cada Textfield
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
                children:[
                  nameRow,
                  emailRow,
                  usernameRow,
                  passwordRow,
                  passwordRepeatRow,
                  registerButtonRow,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  final nameRow = Container(
      child: Column(children: <Widget>[
        TextField(
          autofocus: false,
          obscureText: false,
          decoration: InputDecoration(
              labelText: "Full name: ",
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
      ],)
  );

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
  final usernameRow = Container(
      child: Column(children: <Widget>[
        SizedBox( //caixa do username
          height: 30,
        ),
        TextField(
          autofocus: false,
          obscureText: false,
          decoration: InputDecoration(
              labelText: "Username: ",
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
      )
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
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                      width: 1,
                      color: Colors.green,
                      style: BorderStyle.solid))),
        ),
      ],
      )
  );

  final passwordRepeatRow = Container(
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
              labelText: "Password (again)",
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
      ],
      )
  );
  final registerButtonRow = Container(
      child: Column(children: <Widget>[
        SizedBox( // Register button
          height: 20,
        ),
        ButtonTheme(
          minWidth: double.infinity,
          child: MaterialButton(
            onPressed: () => {
              Navigator.push(
                currentContext,
                MaterialPageRoute(builder: (currentContext) => UserProfile()),
              )
            },
            textColor: Colors.white,
            color: Colors.green,
            height: 60,
            child: Text("Register"),
          ),
        ),
      ],
      )
  );
}