import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/list_attendees.dart';
import 'package:flutter_app/app_screens/select_interests.dart';
import 'package:flutter_app/app_screens/conference_edit.dart';
import 'package:flutter_app/models/Attendee.dart';
import 'package:flutter_app/models/Conference.dart';
import 'package:flutter_app/models/UserData.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ConferencePage extends StatefulWidget {
  final String currentUserId;
  final Conference conf;

  ConferencePage({this.currentUserId, this.conf});

  @override
  _ConferencePageState createState() => _ConferencePageState();
}

class _ConferencePageState extends State<ConferencePage> {
  bool isJoined = false;
  int atCnt = 0;
  Attendee at;
  Map<dynamic, dynamic> topicos;
  List lst;

  Map<dynamic, dynamic> _generateTopics() {
    var myMap = new Map<dynamic, dynamic>();

    lst.forEach((f) => myMap[f] = false);

    return myMap;
  }

  _logout() {
    AuthService.logout();
    Navigator.pop(context);
  }

  joinEvent(Conference conf) {
    if (topicos == null || topicos.isEmpty)
      topicos = _generateTopics();

    Database.followEvent(
        currentUserId: widget.currentUserId,
        eventId: conf.eventId,
        topics: topicos);

    setState(() {
      isJoined = true;
      atCnt++;
    });

    print(topicos);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => SelectInterests(
                  topicMap: _generateTopics(),
                  eventId: conf.eventId,
                  userId: widget.currentUserId,
                )));
  }

  unJoinEvent(Conference conf) {
    Database.unFollowEvent(
        currentUserId: widget.currentUserId, eventId: conf.eventId);

    setState(() {
      isJoined = false;
      atCnt--;
    });
  }

  List _getTopics(Conference conf) {
    List<String> lista = new List();
    conf.topics.forEach(
        (k, v) => v.toString().isNotEmpty ? lista.add(v.toString()) : null);

    return lista;
  }

  _buildTopicTile(String topic) {
    return ListTile(leading: Icon(Icons.star), title: Text(topic));
  }

  @override
  void initState() {
    super.initState();
    _setupIsJoined();
    _setupFollowerCount();
    lst = _getTopics(widget.conf);
    _setupGetTopics();
  }

  _setupGetTopics() async {
    DocumentSnapshot doc = await Database.getTopics(
        currentUserId: widget.currentUserId, eventId: widget.conf.eventId);

    Attendee at = Attendee.fromDoc(doc);

    setState(() {
      topicos = at.topics;
    });

    if (topicos == null || topicos.isEmpty) {
      topicos = _generateTopics();
    }
  }

  _setupIsJoined() async {
    bool isFollowingEvent = await Database.isFollowingEvent(
        currentUserId: widget.currentUserId, eventId: widget.conf.eventId);

    setState(() {
      isJoined = isFollowingEvent;
    });
  }

  _setupFollowerCount() async {
    int userFollowerCnt = await Database.numFollowers(widget.conf.eventId);

    setState(() {
      atCnt = userFollowerCnt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Mingler',
            style: new TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: _logout,
              icon: Icon(Icons.exit_to_app),
              label: Text('Logout'),
            )
          ],
        ),
        body: FutureBuilder(
            future: eventRef.document(widget.conf.eventId).get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              Conference conf = Conference.fromDoc(snapshot.data);
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: conf.imageUrl.isEmpty
                                      ? AssetImage(
                                      'assets/images/event_placeholder.jpg')
                                      : CachedNetworkImageProvider(
                                      conf.imageUrl),
                                )),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: Text(
                                conf.getMonth.toString(),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Text(conf.getDate.day.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ))
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                conf.name,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(Icons.date_range),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              conf.getCalendarDate.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(Icons.location_on),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Column(
                            children: <Widget>[
                              Text(
                                conf.address,
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.alternate_email),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            InkWell(
                              child: Text(
                                conf.urlName.isEmpty
                                    ? conf.urlLink
                                    : conf.urlName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.blue),
                              ),
                              onTap: () => launch(conf.urlLink),
                            )
                          ],
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      height: 10,
                    ),
                    _buildButtonOptions(conf),
                    Divider(
                      color: Colors.black,
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpandablePanel(
                        header: Text(
                          'Details', //para ficar sempre assim, nao mudar
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        expanded: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              conf.descr,
                              softWrap: true,
                            )),
                        tapHeaderToExpand: true,
                        hasIcon: true,
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Events Topics",
                          style:
                          TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        )
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: lst.length,
                      itemBuilder: (BuildContext context, int index) {
                        String topic = _getTopics(conf)[index];
                        return _buildTopicTile(topic);
                      },
                    ),
                    Divider(
                      color: Colors.black,
                      height: 10,
                    ),
                    _buildOwnerButtons(conf),
                  ],
                ),
              );
            }));
  }

  _buildButtonOptions(Conference conf) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              atCnt.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'going',
              style: TextStyle(color: Colors.grey[700]),
            )
          ],
        ),
        buildJoinButton(conf),
        isJoined ? FlatButton(
          onPressed: () => pressedViewTopics(conf),
          child: Text('Topics'),
        )
            : Container()
      ],
    );
  }

  pressedViewTopics(Conference conf)
  {
    _setupGetTopics();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => SelectInterests(
              topicMap: topicos,
              eventId: conf.eventId,
              userId: widget.currentUserId,
            )));
  }

  RaisedButton buildJoinButton(Conference conf) {
    if (!isJoined) {
      return RaisedButton.icon(
        onPressed: () => joinEvent(conf),
        icon: Icon(Icons.add),
        label: Text('join us'),
        color: Colors.green,
      );
    } else {
      return RaisedButton.icon(
        onPressed: () => unJoinEvent(conf),
        icon: Icon(Icons.remove),
        label: Text('unjoin'),
        color: Colors.red,
      );
    }
  }

  _buildOwnerButtons(Conference conf)
  {
    if (conf.ownerId == Provider.of<UserData>(context).currentUserId)
    {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('Edit event'),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ConferenceEdit(conf: conf,))),
          ),
          FlatButton(
            color: Colors.grey,
            textColor: Colors.black,
            child: Text('See Attendees'),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ListAttendees(conf: conf,))),
          ),
        ],
      );
    }
    else{
      return Divider();
    }
  }
}
