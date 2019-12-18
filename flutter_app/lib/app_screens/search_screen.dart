import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/conference_page.dart';
import 'package:flutter_app/models/Conference.dart';
import 'package:flutter_app/models/UserData.dart';
import 'package:flutter_app/services/database.dart';
import 'package:provider/provider.dart';

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
          MaterialPageRoute(builder: (_) => ConferencePage(
            currentUserId: Provider.of<UserData>(context).currentUserId,
            conf: conference,))),
    );
  }

  _clearSearch()
  {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _events = null;
    });
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
              onPressed: _clearSearch,
            ),
            filled: true,
          ),
          onSubmitted: (input){
            if(input.isNotEmpty) {
              setState(() {
                _events = Database.searchEvents(input);
              });
            }
          },
        ),
      ),
      body: _events == null
          ? Center(
        child: Text(
          'Search for an event'
        ),
      )
          : FutureBuilder(
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
