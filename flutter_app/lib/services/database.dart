import 'package:cloud_firestore/cloud_firestore.dart';
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

  static void addMatch(Match match) async{
    DocumentReference ref =  await matchesRef.add({
      'requester' : match.requester,
      'receiver' : match.receiver,
      'event' : match.event,
      'accepted' : match.accepted
    });
  }

}