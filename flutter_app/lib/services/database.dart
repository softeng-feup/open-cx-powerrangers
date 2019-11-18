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

}