import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/Conference.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/utils/constants.dart';

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

    print(ref.documentID);
  }

  static Future<QuerySnapshot> searchEvents(String input)
  {
    Future<QuerySnapshot> events = eventRef.where('name', isGreaterThanOrEqualTo: input).getDocuments();
    return events;
  }

  static void followEvent ({String currentUserId, String eventId})
  {
    //adiciona o evento à lista de eventos que o currentUser se juntou
    followingRef.document(currentUserId).collection('userFollowing').document(eventId).setData({});

    //adiciona o currentUser à lista de users que seguem o evento eventId
    followersRef.document(eventId).collection('userFollowers').document(currentUserId).setData({});
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

}