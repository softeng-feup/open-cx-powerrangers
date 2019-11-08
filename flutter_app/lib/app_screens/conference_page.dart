import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';

class ConferencePage extends StatefulWidget {
  @override
  _ConferencePageState createState() => _ConferencePageState();
}

class _ConferencePageState extends State<ConferencePage> {
  bool isJoined = false;

  joinEvent() {
    print('following event');
    setState(() {
      isJoined = true;
    });
  }

  unJoinEvent() {
    print('unfollowing event');
    setState(() {
      isJoined = false;
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
            onPressed: () => AuthService.logout(),
            icon: Icon(Icons.exit_to_app),
            label: Text('Logout'),
          )
        ],
      ),
      body: Column(
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
                          image: AssetImage('assets/images/event_placeholder.jpg'),
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
                          'Dez',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Text(
                        '21',
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
                            'Conference name',
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
                        '21/12/2019',
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
                          'Faculdade de Engenharia da Universidade do Porto',
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
                color: Colors.grey[400],
                height: 35,
                thickness: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildJoinButton(),
                ],
              ),
              Divider(
                color: Colors.grey[400],
                height: 35,
                thickness: 15,
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
                            'stuff stuff stuff stuff stuff',
                            softWrap: true,
                          )
                      ),
                      tapHeaderToExpand: true,
                      hasIcon: true,
                    ),
              ),
            ],
      )
    );
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
