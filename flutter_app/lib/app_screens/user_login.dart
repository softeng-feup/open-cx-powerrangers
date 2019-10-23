import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/homePage.dart';
import 'package:flutter_app/app_screens/main_Menu.dart';
import 'package:flutter_app/app_screens/user_register.dart';
import 'user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';




class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}


enum FormType {
  login,
  register
}

class _UserLoginState extends State<UserLogin> {
  //TODO: Criar tipo de letra no inicio para nao repetir em cada Textfield



  final formKey = GlobalKey<FormState>();

  String _email, _password, errorMsg;
  FormType _formType = FormType.login;
  bool _loading = false;

  bool validateandsave(){
    final form = formKey.currentState;
      if(form.validate()){
        form.save();
        _loading = true;
        return true;
      }
      else{
        return false;
      }
  }

  void validateandsubmit() async {
    if(validateandsave()){
      try{
        if(_formType == FormType.login){
          FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
          print("Signed in: ${user.uid}");
        }
        else{
          FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
          print("Registered in: ${user.uid}");
        }
      } catch (e){
        switch(e.code){
          case "ERROR_USER_NOT_FOUND":
            {
              errorMsg =
                "There is no user with such entries. Please try again.";
              _loading = false;

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;

          case "ERROR_WRONG_PASSWORD":
            {
              errorMsg = "Password doesn\'t match your email.";
              _loading = false;

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;

          case "ERROR_EMAIL_ALREADY_IN_USE":
            {

              errorMsg = "This email is already in use.";
              _loading = false;

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;

          case "ERROR_WEAK_PASSWORD":
            {

              errorMsg = "The password must be 6 characters long or more.";
              _loading = false;

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;

          default:
            {

              errorMsg = "";

            }
        }
      }
    }
  }

  void movetoregister(){
    setState(() {
      _formType = FormType.register;
    });
  }

  void movetologin(){
    setState(() {
      _formType = FormType.login;
    });
  }


  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: inputs() + loginButtons() + registerButtons()
            ),
          ),
        ),
      ),
    );
  }



  List<Widget> inputs(){
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value) => value.isEmpty ? 'Email not valid': null,
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Password not valid': null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> loginButtons(){
    return [

              SizedBox( //caixa da password
              height: 30,
              ),
              ButtonTheme(
              //elevation: 4,
              //color: Colors.green,
              minWidth: double.infinity,
                child: MaterialButton(
                  onPressed: (){
                    movetologin();
                    validateandsubmit();
                    if(_loading == true){
                      Navigator.push(
                        currentContext,
                        MaterialPageRoute(builder: (currentContext) => MainMenu()),
                      );
                    }

                  },
                  textColor: Colors.white,
                  color: Colors.green,
                  height: 50,
                  child: Text("Login"),
        ),
      ),
    ];

  }

  List<Widget> registerButtons(){
    return [
      SizedBox( //caixa da password
        height: 30,
      ),
      ButtonTheme(
        //elevation: 4,
        //color: Colors.green,
        minWidth: double.infinity,
        child: MaterialButton(
          onPressed: (){
            movetoregister();
            validateandsubmit();
            if(_loading == true){
              Navigator.push(
                currentContext,
                MaterialPageRoute(builder: (currentContext) => UserRegister()),
              );
            }
          },
          textColor: Colors.white,
          color: Colors.red,
          height: 50,
          child: Text("Register"),
        ),
      ),
    ];
  }
}