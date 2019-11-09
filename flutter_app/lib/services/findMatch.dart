import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/utils/constants.dart';


class FindMatch{

  findRandomMatch(){
    return usersRef
    .limit(5)
    .getDocuments();
  }

}