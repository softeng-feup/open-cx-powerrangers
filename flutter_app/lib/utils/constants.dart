import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _fireStore = Firestore.instance;
final storageRef = FirebaseStorage.instance.ref();
final usersRef = _fireStore.collection('users');
final eventRef = _fireStore.collection('events');
final followersRef = _fireStore.collection('followers');
final followingRef = _fireStore.collection('following');