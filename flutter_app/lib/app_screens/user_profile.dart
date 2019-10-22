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
          child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[Container(
                child: leftColumn,
                width: 200,
              ),
                Container(
                  child: rightColumn,
                  width: 200,
                ),
              ],
          ),
          ),
        ),
    );
  }

  final leftColumn = Container(
    child: Column(children: <Widget>[
      TextField(
        autofocus: false,
        obscureText: false,
        decoration: InputDecoration(
          labelText: ":)",
          hintText: "Rating",
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
  final rightColumn = Container(width: 30,
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

        SizedBox( //caixa dos interesses
          height: 30,
        ),
        TextField(
          enabled: false,
          autofocus: false,
          obscureText: false,
          decoration: InputDecoration(
              labelText: "Interests",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                      width: 0,
                      color: Colors.green,
                      style: BorderStyle.solid))),
        ),
      ],)
  );
}