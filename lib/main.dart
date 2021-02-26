import 'package:flutter/material.dart';
import 'package:projectapp/screen/login.dart';

void main(List<String> args) {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  Myapp({Key key}) : super(key: key);

  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V-care',
      home: Login(),
    );
  }
}
