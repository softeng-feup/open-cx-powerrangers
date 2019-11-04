import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid, name, email, profileImageUrl, bio;
  //interests?

  User({
    this.uid,
    this.name,
    this.email,
    this.profileImageUrl,
    this.bio});

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      uid: doc.documentID,
      name: doc['name'],
      email: doc['email'],
      profileImageUrl: doc['profileImageUrl'],
      bio: doc['bio'] ?? ''
    );
  }
}