import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/BaseAppBar.dart';
import 'package:flutter_app/app_screens/user_register.dart';
import 'auth.dart';


class UserLogin extends StatefulWidget {
  UserLogin({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _UserLoginState createState() => _UserLoginState();
}


enum FormType {
  login,
  register
}

class _UserLoginState extends State<UserLogin> {

  final formKey = GlobalKey<FormState>();

  String _email, _password, errorMsg;
  FormType _formType = FormType.login;
  bool _loading = false;

  bool validateAndSave(){
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

  void validateAndSubmit() async {

    String userID;

    if(validateAndSave()){
      try{
        if(_formType == FormType.login){
          userID = await widget.auth.signInWithEmailAndPassword(_email, _password);
          print("Signed in: $userID");
        }
        else{
          userID = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print("Registered in: $userID");
        }

        widget.onSignedIn();

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

  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }


  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return Scaffold(
      appBar: new AppBar(
        title: Text('Mingler', style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: inputs() + buildSubButtons()
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

  List<Widget> buildSubButtons()
  {
    if(_formType == FormType.login) {
      return [
        new RaisedButton(
          color: Colors.green,
          textColor: Colors.white,
          child: new Text('Login', style: new TextStyle(fontSize: 20),),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text('Register', style: new TextStyle(fontSize: 20),),
          onPressed: moveToRegister,
        )
      ];
    }
    else {
      return [
        new RaisedButton(
          color: Colors.red,
          textColor: Colors.white,
          child: new Text('Register', style: new TextStyle(fontSize: 20),),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text('Have an account? Login', style: new TextStyle(fontSize: 20),),
          onPressed: moveToLogin,
        )
      ];
    }
  }
}