import 'package:flutter/material.dart';


class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {//TODO: Criar tipo de letra no inicio para nao repetir em cada Textfield; Alterar estrutura do codigo para a do userLogin

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(     // Barra azul no topo - TODO: Arranjar forma de não ter de repetir em todos os ecras;
        centerTitle: true,
        title: Text(
          'Mingler',
        ),
      ),
      //resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child:Column(
            children: <Widget>[
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children:[Container(
              child: leftColumnTop,
              width: 200,
            ),
              Container(
                child: rightColumnTop,
                width: 200,
              ),
            ],
          ),
              Row(
              children:[Container(
                child: ColumnBottom,
                width: 400,
              )]
              ),
            ],
          ),
        ),
          ),
        );
  }


  final leftColumnTop = Container(
    child: Column(children: <Widget>[
      TextField(//photoDummy
        enabled: false,
        autofocus: false,
        obscureText: false,
        decoration: InputDecoration(
          labelText: ":)",
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 200,
          ),
        ),
      ),
      SizedBox( //caixa dos ratings
        height: 30,
      ),
      TextField(
        enabled: false,
        autofocus: false,
        obscureText: false,
        decoration: InputDecoration(
            labelText: "★★★★☆",
            hintText: "Rating",
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 40,
            ),
        ),
      ),
    ],)
  );

  final rightColumnTop = Container(width: 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
        TextField(
          enabled: false,
          autofocus: false,
          obscureText: false,
          decoration: InputDecoration(
              labelText: "Anthony",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
          ),
        ),
        SizedBox( // caixa da description
          height: 30,
        ),
        TextField(
          maxLines: 8, //to expand height
          enabled: false,
          autofocus: false,
          decoration: InputDecoration(
              labelText: "Sports fan, FC Porto\n supporter.\n Web developer, with\n about 10 years\n experience.\n\n\n",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
          ),
        ),
      ],)
  );

  final ColumnBottom = Container(
      child: Column(children: <Widget>[
        TextField(//interests
          maxLines: 8,
          enabled: false,
          autofocus: false,
          obscureText: false,
          decoration: InputDecoration(
            labelText: "I am interested in: I am interested in: \nI am interested in: I am interested in: \nI am interested in: I am interested in: I am interested in: I am interested in: ",
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ],)
  );
}