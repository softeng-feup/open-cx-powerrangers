import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_screens/conference_edit.dart';
import 'package:flutter_app/models/Conference.dart';
import 'package:flutter_app/models/UserData.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ConferencePage extends StatefulWidget {
  final String currentUserId;
  final String eventId;

  ConferencePage({this.currentUserId, this.eventId});

  @override
  _ConferencePageState createState() => _ConferencePageState();
}

class _ConferencePageState extends State<ConferencePage> {
  bool isJoined = false;
  int atCnt = 0;

  _logout()
  {
    AuthService.logout();
    Navigator.pop(context);
  }

  joinEvent() {

    Database.followEvent(
        currentUserId: widget.currentUserId,
        eventId: widget.eventId);

    setState(() {
      isJoined = true;
      atCnt++;
    });
  }

  unJoinEvent() {

    Database.unFollowEvent(
      currentUserId: widget.currentUserId,
      eventId: widget.eventId
    );

    setState(() {
      isJoined = false;
      atCnt--;
    });
  }

  List _getTopics(Conference conf)
  {
    List<String> lst = new List();
    conf.topics.forEach((k,v) => v.toString().isNotEmpty
    ? lst.add(v.toString())
    : null);

    return lst;
  }

  _buildTopicTile(String topic)
  {
    return ListTile(
      leading: Icon(Icons.star),
      title: Text(topic)
    );
  }

  @override
  void initState() {
    super.initState();
    _setupIsJoined();
    _setupFollowerCount();
  }

  _setupIsJoined() async
  {
    bool isFollowingEvent = await Database.isFollowingEvent(
      currentUserId: widget.currentUserId,
      eventId: widget.eventId
    );

    setState(() {
      isJoined = isFollowingEvent;
    });
  }

  _setupFollowerCount() async
  {
    int userFollowerCnt = await Database.numFollowers(widget.eventId);

    setState(() {
      atCnt = userFollowerCnt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mingler', style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
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
        future: eventRef.document(widget.eventId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData)
          {
            return Center(
              child: CircularProgressIndicator()
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
                                  ? AssetImage('assets/images/event_placeholder.jpg')
                                  : CachedNetworkImageProvider(conf.imageUrl),
                            )
                        ),
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
                        Text(
                            conf.getDate.day.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            )
                        )
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
                            ),),
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
                          style: TextStyle(
                              fontSize: 20
                          ),
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
                            style: TextStyle(
                                fontSize: 20
                            ),
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
                                color: Colors.blue
                            ),
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
                          fontSize: 20,
                          fontWeight: FontWeight.w800
                      ),
                    ),
                    expanded: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          conf.descr,
                          softWrap: true,
                        )
                    ),
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                      ),)
                  ],
                ),
                ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _getTopics(conf).length,
                      itemBuilder: (BuildContext context, int index){
                        String topic = _getTopics(conf)[index];
                        return _buildTopicTile(topic);
                      },
                  ),
              ],
            ),
          );
        })
    );
  }

  _buildButtonOptions(Conference conf)
  {
    if (conf.ownerId == Provider.of<UserData>(context).currentUserId)
    {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  atCnt.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  'going',
                  style: TextStyle(
                      color: Colors.grey[700]
                  ),
                )
              ],
            ),
            buildJoinButton(),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('Edit event'),
              onPressed: () => Navigator.push(
                context,
              MaterialPageRoute(builder: (_) => ConferenceEdit(conf: conf,))),
              ),
          ],
        );
    }
    else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                      atCnt.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                ),
                Text(
                  'attendees',
                  style: TextStyle(
                    color: Colors.grey[700]
                  ),
                )
              ],
            ),
            buildJoinButton(),
        ]
      );
    }
  }

  RaisedButton buildJoinButton()
  {
    if(!isJoined)
    {
      return RaisedButton.icon(
            onPressed: joinEvent,
            icon: Icon(Icons.add),
            label: Text('join us'),
            color: Colors.green,
      );
    }
    else {
      return RaisedButton.icon(
          onPressed: unJoinEvent,
          icon: Icon(Icons.remove),
          label: Text('unjoin'),
          color: Colors.red,
      );
    }
  }
}
