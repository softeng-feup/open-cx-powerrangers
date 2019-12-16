import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/Attendee.dart';
import 'package:flutter_app/models/Conference.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:flutter_app/models/Match.dart';


class Database{

  static void updateUser(User user)
  {
    usersRef.document(user.uid).updateData({
      'name': user.name,
      'bio': user.bio,
      'profileImageUrl': user.profileImageUrl
    });
  }

  static void updateConference(Conference conf)
  {
    eventRef.document(conf.eventId).updateData({
      'address': conf.address,
      'date': conf.date,
      'descr': conf.descr,
      'name': conf.name,
      'ownerId': conf.ownerId,
      'urlLink': conf.urlLink,
      'urlName': conf.urlName,
      'imageUrl': conf.imageUrl,
      'topics': conf.topics
    });
  }

  static void createConference(Conference conf) async
  {
    DocumentReference ref = await eventRef.add({
      'address': conf.address,
      'date': conf.date,
      'descr': conf.descr,
      'name': conf.name,
      'ownerId': conf.ownerId,
      'urlLink': conf.urlLink,
      'urlName': conf.urlName,
      'imageUrl': conf.imageUrl,
      'topics': conf.topics
    });
  }

  static Future<QuerySnapshot> searchEvents(String input)
  {
    Future<QuerySnapshot> events = eventRef.where('name', isGreaterThanOrEqualTo: input).getDocuments();
    return events;
  }

  static Future<QuerySnapshot> getEvents(String uid)
  {
    Future<QuerySnapshot> events = followingRef.document(uid).collection('userFollowing').getDocuments();

    return events;
  }

  static getTopics ({String currentUserId, String eventId}) async
  {
    DocumentSnapshot doc = await followersRef.document(eventId).collection('userFollowers')
        .document(currentUserId).get();

    return doc;
  }

  static Future<User> getUser({String uid}) async
  {
      DocumentSnapshot doc = await usersRef.document(uid).get();

      User user = User.fromDoc(doc);

      return user;
  }

  static void followEvent ({String currentUserId, String eventId, Map topics}) async
  {
    User user = await getUser(uid: currentUserId);

    //adiciona o evento à lista de eventos que o currentUser se juntou
    followingRef.document(currentUserId).collection('userFollowing').document(eventId).setData({});

    //adiciona o currentUser à lista de users que seguem o evento eventId
    followersRef.document(eventId).collection('userFollowers').document(currentUserId).setData({
      'name': user.name,
      'topics': topics
    });
  }

  static void unFollowEvent ({String currentUserId, String eventId})
  {
    //remove o evento da lista de eventos que o currentUser se juntou
    followingRef.document(currentUserId).collection('userFollowing').document(eventId).get()
    .then((doc){
      if(doc.exists)
        doc.reference.delete();
    });

    //remove o currentUser da lista de users que seguem o evento eventId
    followersRef.document(eventId).collection('userFollowers').document(currentUserId).get()
    .then((doc){
      if(doc.exists)
        doc.reference.delete();
    });
  }

  static Future<bool> isFollowingEvent({String currentUserId, String eventId}) async
  {
    DocumentSnapshot followingDoc = await followersRef.document(eventId).collection('userFollowers')
        .document(currentUserId).get();

    return followingDoc.exists;
  }

  static Future<int> numFollowers(String eventId) async {
    QuerySnapshot followersSnap = await followersRef.document(eventId).collection('userFollowers').getDocuments();

    return followersSnap.documents.length;
  }

  static Future<List<DocumentSnapshot>> getAttendees(String eventId) async {
    QuerySnapshot followersSnap = await followersRef.document(eventId).collection('userFollowers').getDocuments();

    return followersSnap.documents;
  }

  Future<String> addMatch(Match match) async{
    DocumentReference ref =  await matchesRef.add({
      'requester': match.requester,
      'receiver': match.receiver,
      'event': match.event,
      'accepted': match.accepted,
      'completed': match.completed,
      'rating': match.rating
    });
    String matchid = ref.documentID;

    return Future.value(matchid);

  }

  static void updateMatch(Match match) async{
    matchesRef.document(match.uid).updateData({
      'requester': match.requester,
      'receiver': match.receiver,
      'event': match.event,
      'accepted': match.accepted,
      'completed': match.completed,
      'rating': match.rating
    });
  }

  static Future<QuerySnapshot> findMatch2Pair(String eventname, String id) async{
    QuerySnapshot event = await eventRef.where('name', isEqualTo: eventname).getDocuments();

    Conference conf = Conference.fromDoc(event.documents[0]);

    DocumentSnapshot topics = await followersRef.document(conf.eventId).collection('userFollowers').document(id).get();

    Attendee requester = Attendee.fromDoc(topics);

    QuerySnapshot randomUser1 = await followersRef.document(conf.eventId).collection('userFollowers').where('name', isGreaterThan: id).getDocuments();
    QuerySnapshot randomUser2 = await followersRef.document(conf.eventId).collection('userFollowers').where('name', isLessThan: id).getDocuments();

    Attendee receiver;

    if(randomUser1.documents.length > 0){
      var compatible = false;
      var match;
      for(int i = 0; i < randomUser1.documents.length; i++){
        receiver = Attendee.fromDoc(randomUser1.documents[i]);
        requester.topics.forEach((key1,value1){
          receiver.topics.forEach((key2,value2){
            if(key1 == key2 && value1 == value2){
              compatible = true;
            }
          });
          if(compatible == true){
            match = receiver;
          }
        });
        if(compatible == true){
          QuerySnapshot m = await usersRef.where('name',isEqualTo: match.name).getDocuments();
          return m;
        }
      }
    }
    if(randomUser2.documents.length > 0){
      var compatible = false;
      var match;
      for(int i = 0; i < randomUser2.documents.length; i++){
        receiver = Attendee.fromDoc(randomUser2.documents[i]);
        requester.topics.forEach((key1,value1){
          receiver.topics.forEach((key2,value2){
            if(key1 == key2 && value1 == value2){
              compatible = true;
            }
          });
          if(compatible == true){
            match = receiver;
          }
        });
        if(compatible == true){
          QuerySnapshot m = await usersRef.where('name',isEqualTo: match.name).getDocuments();
          return m;
        }
      }
    }

    return null;
  }

}