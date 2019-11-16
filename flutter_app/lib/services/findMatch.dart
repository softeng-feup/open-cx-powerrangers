import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/utils/constants.dart';


class FindMatch{


  Future findRandomMatch(userId) async{

    QuerySnapshot query = await usersRef.where("uid",isGreaterThan: userId).getDocuments();

    return query.documents;
  }



}