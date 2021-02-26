import 'package:flutter/material.dart';
import 'package:projectapp/screen/nurse/profilen.dart';
import 'package:projectapp/utility/mystyle.dart';

import '../login.dart';
import 'comment.dart';
import 'home.dart';

class CalendarN extends StatefulWidget {
  CalendarN({Key key}) : super(key: key);

  @override
  _CalendarNState createState() => _CalendarNState();
}

class _CalendarNState extends State<CalendarN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CALENDAR'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (value) => Login());
                Navigator.pushAndRemoveUntil(context, route, (route) => false);
              })
        ],
      ),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHead(),
            homeMenu(),
            calenderMenu(),
            messageMenu(),
            profileMenu()
          ],
        ),
      );

  ListTile homeMenu() {
    return ListTile(
      leading: Icon(
        Icons.home,
        color: Colors.blue,
      ),
      title: Text(
        'HOME',
        style: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route = MaterialPageRoute(builder: (value) => Home());
        Navigator.push(context, route);
      },
    );
  }

  ListTile calenderMenu() {
    return ListTile(
      leading: Icon(
        Icons.calendar_today,
        color: Colors.blue,
      ),
      title: Text(
        'CALENDER',
        style: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => CalendarN());
        Navigator.push(context, route);
      },
    );
  }

  ListTile messageMenu() {
    return ListTile(
      leading: Icon(
        Icons.comment,
        color: Colors.blue,
      ),
      title: Text(
        'COMMENT',
        style: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Comment());
        Navigator.push(context, route);
      },
    );
  }

  ListTile profileMenu() {
    return ListTile(
      leading: Icon(
        Icons.person,
        color: Colors.blue,
      ),
      title: Text(
        'PROFILE',
        style: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Profilen());
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
