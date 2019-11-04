import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/user_register.dart';
import 'package:flutter_app/services/auth.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();


      AuthService.login(_email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Mingler', style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (input) => !input.contains('@')
                              ? 'Please enter a valid email'
                              : null,
                          onSaved: (input) => _email = input,
                        ),
                      TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          validator: (input) => input.length < 6
                              ? 'Must be at least 6 characters'
                              : null,
                          onSaved: (input) => _password = input,
                          obscureText: true,
                        ),
                      RaisedButton(
                          onPressed: _submit,
                          color: Colors.green,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      FlatButton(
                          onPressed: () => Navigator.pushNamed(context, SignupScreen.id),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}