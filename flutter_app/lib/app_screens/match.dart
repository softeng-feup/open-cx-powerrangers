import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/app_screens/main_Menu.dart';
import 'package:flutter_app/app_screens/root.dart';

class Match extends StatefulWidget {
  @override
  _MatchState createState() => _MatchState();
}

var currentContext;

class _MatchState extends State<Match> {
  //TODO: Criar tipo de letra no inicio para nao repetir em cada Textfield; Mudar TextField para um tipo de caixa read-only

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return Scaffold(
      // TODO - Adicionar botao edit, permite utilizador editar perfil
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Match'),
          centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Container(
                  child: imageColumn,
                  width: 400,
                )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Container(
                  child: textColumn,
                  width: 400,
                )
                ],
              ),
              Row(
                  children: [Container(
                    child: acceptButton,
                    width: 200,
                    height: 200,
                  ),
                    Container(
                      child: rejectButton,
                      width: 200,
                      height: 200,
                    )
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }

  final imageColumn = Container( //Match profile pic
      child: Column(children: <Widget>[
        TextField(
          textAlign: TextAlign.center,
          enabled: false,
          autofocus: false,
          obscureText: false,
          decoration: InputDecoration(
            labelText: "☺",
            hintText: "Rating",
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 100,
            ),
          ),
        ),
      ],
      )
  );

  final textColumn = Container( //Match generic text
      child: Column(children: <Widget>[
        TextField(
          maxLines: 5,
          enabled: false,
          autofocus: false,
          obscureText: false,
          decoration: InputDecoration(
            labelText: "John wants to Mingle\n with you!",
            hintText: "Rating",
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 35,
            ),
          ),
        ),
      ],
      )
  );

  final acceptButton = Container(
      child: Column(children: <Widget>[
        SizedBox( // Register button
          height: 20,
        ),
        ButtonTheme(
          minWidth: double.infinity,
          height: 100,
          child: RaisedButton(
            shape: acceptButtonShape,
            onPressed: () =>
            {
              Navigator.push(
                currentContext,
                MaterialPageRoute(builder: (currentContext) => RootPage()),
              )
            },
            textColor: Colors.white,
            color: Colors.green,
            child: Text("✓", textScaleFactor: 5),
          ),
        ),
      ],
      )
  );

  final rejectButton = Container(
      child: Column(children: <Widget>[
        SizedBox( // Register button
          height: 20,
        ),
        ButtonTheme(
          minWidth: double.infinity,
          height: 100,
          child: RaisedButton(
            shape: rejectButtonShape,
            onPressed: () =>
            {
              Navigator.push(
                currentContext,
                MaterialPageRoute(builder: (currentContext) => RootPage()),
              )
            },
            textColor: Colors.white,
            color: Colors.red,
            child: Text("X", textScaleFactor: 5),
          ),
        ),
      ],
      )
  );
}

final rejectButtonShape = CircleBorder(
    side: BorderSide(color: Colors.red)
);

final acceptButtonShape = CircleBorder(
    side: BorderSide(color: Colors.green)
);