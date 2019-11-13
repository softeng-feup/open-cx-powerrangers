import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _events;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15.0),
            border: InputBorder.none,
            hintText: 'Search events',
            prefixIcon: Icon(
                Icons.search,
                size: 30.0,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => print('clear'),
            ),
            filled: true,
          ),
          onSubmitted: (input){
            print(input);
          },
        ),
      ),
      /*body: FutureBuilder(
        future: _events,
        builder: (context, snapshot){
          if(!snapshot.hasData){
          }
        },
      ),*/
    );
  }
}
