import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text('Home')
      ),
      body: new Container(
        child: new Text('your feed is empty :(')
      ),
    );
  }
}