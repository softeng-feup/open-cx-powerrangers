

import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/homePage.dart';
import 'package:flutter_app/services/findMatch.dart';

class WaitMatch extends StatefulWidget{
  final String currentMatch = "";

  @override
  _WaitMatchState createState() => _WaitMatchState();

}

class _WaitMatchState extends State<WaitMatch> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ,
        builder: ( _,snapshot){
          if(!snapshot.hasData){// or match is not accepted and timeout not reached
            return Center(
                child: CircularProgressIndicator()
            );
          }
          else if( null){// timeout
            return null;
            //return Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage());
          }
          else{
            return Scaffold(
              appBar: AppBar(
                title: Text("Mingler"),
                centerTitle: true,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    // TODO : SEND TO MEETUP SCREEN
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}