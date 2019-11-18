import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/conference_page.dart';
import 'package:flutter_app/models/Conference.dart';
import 'package:flutter_app/services/database.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _events;

  _buildEventTile(Conference conference)
  {
    return ListTile(
      leading: CircleAvatar(
        radius: 20.0,
        backgroundImage: conference.imageUrl.isEmpty
            ? AssetImage('assets/images/event_placeholder.jpg')
            : CachedNetworkImageProvider(conference.imageUrl)
      ),
      title: Text(conference.name),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ConferencePage(eventId: conference.eventId,))),
    );
  }

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
            setState(() {
              _events = Database.searchEvents(input);
            });
          },
        ),
      ),
      body: FutureBuilder(
        future: _events,
        builder: (context, snapshot){
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.data.documents.length == 0)
          {
            return Center(
              child: Text(
                  'No events found. Please try again! (the search is case-sensitive)'
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index){
              Conference conf = Conference.fromDoc(snapshot.data.documents[index]);
              return _buildEventTile(conf);
            },
          );
        }
      ),
    );
  }
}
