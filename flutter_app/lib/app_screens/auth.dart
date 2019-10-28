import 'package:firebase_auth/firebase_auth.dart';

//class for all authentication related code

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentState();
  Future<void> signOut();
}

class Auth implements BaseAuth{
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(String email, String password) async
  {
    FirebaseUser user = (await _fireBaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;

    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(String email, String password) async
  {
    FirebaseUser user = (await _fireBaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;
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