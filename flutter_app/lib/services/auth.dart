import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/User.dart';

//class for all authentication related code

abstract class BaseAuth {
  User _userFromFirebase(FirebaseUser user);
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentState();
  Future<void> signOut();
}

class Auth implements BaseAuth{
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user)
  {
    if (user != null)
      return User(uid: user.uid);
    else
      return null;
  }

  Stream<User> get user{
    return _fireBaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async
  {
    FirebaseUser user = (await _fireBaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return _userFromFirebase(user);
  }

  Future<User> createUserWithEmailAndPassword(String email, String password) async
  {
    FirebaseUser user = (await _fireBaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    return _userFromFirebase(user);
  }

  Future<String> currentState() async
  {
    FirebaseUser user = await _fireBaseAuth.currentUser();
    return user.uid;
  }

  Future<void> signOut() async
  {
    return _fireBaseAuth.signOut();
  }
}