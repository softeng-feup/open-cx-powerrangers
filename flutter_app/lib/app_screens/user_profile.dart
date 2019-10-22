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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[Container(
                width: 250, child: leftColumn,
              ),
                Container(
                  width: 150, child: rightColumn,
                ),
              ],
          ),
          ),
        ),
    );
  }

  final leftColumn = Container(width: 30,
    child: Column(children: <Widget>[
      /*TextField(
        autofocus: false,
        obscureText: false,
        decoration: InputDecoration(
            labelText: "PlaceForPicture",
            hintText: "Picture",
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
      ),*/
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
      child: Column(children: <Widget>[
        TextField(
          enabled: false,
          autofocus: false,
          obscureText: false,
          decoration: InputDecoration(
              labelText: "My Guy",
              hintText: "Name",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
          ),
        ),
        SizedBox( // caixa da description
          height: 70,
        ),
        TextField(
          enabled: false,
          autofocus: false,
          decoration: InputDecoration(
              labelText: "Sports fan, FC Porto supporter.\n Web developer, with about 10 years experience.",
              hintText: "Description",
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                      width: 1,
                      color: Colors.blue,
                      style: BorderStyle.solid))),
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
              hintText: "Interests",
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