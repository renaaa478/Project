import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Colors.blue.shade500;
  Color primaryColor = Colors.blue.shade700;
  SizedBox mySizeBox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Widget titleCenter(String string) {
    return Center(
      child: Text(
        string,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  BoxDecoration boxDecoration(String namePic) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/$namePic'),
        fit: BoxFit.cover,
      ),
    );
  }

  Text showText(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.blue.shade800,
          fontWeight: FontWeight.bold,
        ),
      );
  Container showLogo() {
    return Container(
      width: 200.0,
      child: Image.asset('images/logo1.png'),
    );
  }
  

  Widget ShowProgess() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  MyStyle();
}
