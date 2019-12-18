import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/root.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:flutter_app/services/findMatch.dart';


class MatchRequests extends StatefulWidget{

  @override
  _StateMatchRequests createState() => _StateMatchRequests();
}

var currentContext;

class _StateMatchRequests extends State<MatchRequests>{

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Match"),
        centerTitle: true,
      ),
      body: Container(
        child: Text(
          "WORK IN PROGRESS"
        ),
      ),
    );
  }

}