import 'dart:developer';
import 'package:projectapp/screen/patient/service.dart';
import 'package:flutter/material.dart';
import 'package:projectapp/screen/patient/patientMain.dart';
import 'package:projectapp/screen/patient/profile1.dart';
import 'package:projectapp/utility/mystyle.dart';
class Calender extends StatefulWidget {
  Calender({Key key}) : super(key: key);

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text('Calendar'),),
       drawer: showDrawer(),
    );
  }
   Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHead(),
            homeMenu(),
            homebook(),
            calenderMenu(),
            // messageMenu(),
            profileMenu()
          ],
        ),
      );

  ListTile homeMenu() {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text('HOME'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Home1());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      },
    );
  }

  ListTile homebook() {
    return ListTile(
      leading: Icon(Icons.book),
      title: Text('SERVICE'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Service());
        Navigator.push(context, route);
      },
    );
  }

  ListTile calenderMenu() {
    return ListTile(
      leading: Icon(Icons.calendar_today),
      title: Text('CALENDAR'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Calender());
        Navigator.push(context, route);
      },
    );
  }

  // ListTile messageMenu() {
  //   return ListTile(
  //     leading: Icon(Icons.android),
  //     title: Text('MESSAGE'),
  //     onTap: () {
  //       Navigator.pop(context);
  //       MaterialPageRoute route =
  //           MaterialPageRoute(builder: (value) => Profile1());
  //       Navigator.push(context, route);
  //     },
  //   );
  // }

  ListTile profileMenu() {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text('PROFILE'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Profile1());
        Navigator.push(context, route);
      },
    );
  }

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
        decoration: MyStyle().boxDecoration('paa.jpg'),
        // currentAccountPicture: MyStyle().showLogo(),
        accountName: Text('Name'),
        accountEmail: Text('xxxxx'));
  }
}