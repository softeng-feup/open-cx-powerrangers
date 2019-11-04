import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';

class SignupScreen extends StatefulWidget {
  static final String id = 'signup_screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name, _email, _password;

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // Logging in the user w/ Firebase
      AuthService.signUpUser(context, _name, _email, _password);
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
                          decoration: InputDecoration(labelText: 'Name'),
                          validator: (input) => input.trim().isEmpty
                              ? 'Please enter a valid name'
                              : null,
                          onSaved: (input) => _name = input,
                        ),
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
                          color: Colors.red,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Already have an account? Login',
                            style: TextStyle(
                              fontSize: 16.0,
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