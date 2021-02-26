import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projectapp/model/getNurse.dart';

import 'package:projectapp/screen/nurse/calendar.dart';
import 'package:projectapp/screen/nurse/comment.dart';
import 'package:projectapp/screen/nurse/home.dart';
import 'package:projectapp/screen/nurse/hostorybook.dart';
import 'package:projectapp/screen/nurse/newjob.dart';
import 'package:projectapp/screen/nurse/prodetailn.dart';
import 'package:flutter/material.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';
import 'book1.dart';

class Profilen extends StatefulWidget {
  Profilen({
    Key key,
  }) : super(key: key);

  @override
  _ProfilenState createState() => _ProfilenState();
}

class _ProfilenState extends State<Profilen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String nameUser, surname, username;
  GetNurse getNurse;
  @override
  void initState() {
    super.initState();
    findUser();

    _tabController = TabController(length: 3, vsync: this);
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('name');
      surname = preferences.getString('sername');
      username = preferences.getString('user');
    });
  }

  Future<Null> checkUser() async {
    String url =
        '${MyCostant().domain}/care/app/getNurse.php?isAdd=true&user=$username';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      for (var map in result) {
        GetNurse getNurse = GetNurse.fromJson(map);
        if (getNurse.user != null) {
          routeTuService(ProDetail1(), getNurse);
        }
      }
    } catch (e) {}
  }

  Future<Null> routeTuService(Widget myWidget, GetNurse getNurse) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('nid', getNurse.nId);
    preferences.setString('nname', getNurse.nName);
    preferences.setString('nsurname', getNurse.nSername);
    preferences.setString('nemail', getNurse.nEmail);
    preferences.setString('nphone', getNurse.nPhone);
    preferences.setString('nage', getNurse.nAge);
    preferences.setString('nsex', getNurse.nSex);
    preferences.setString('nb', getNurse.nBirth);
    preferences.setString('nhight', getNurse.nHeight);
    preferences.setString('nweight', getNurse.nWeight);
    preferences.setString('type', getNurse.nnName);
    preferences.setString('Nadd', getNurse.nAdd);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Porfile'),
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
      body: ListView(
        padding: EdgeInsets.only(left: 20.0, top: 20.0),
        children: <Widget>[
          SizedBox(height: 15.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/nurse.jpg'))),
            ),
            Text(
              '$nameUser $surname',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            FlatButton(
              onPressed: () {
                checkUser();
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Icon(Icons.navigate_next),
            ),
          ]),
          SizedBox(height: 15.0),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.lightBlue,
            isScrollable: true,
            labelPadding: EdgeInsets.only(right: 50.0),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                child: Text(
                  'งานใหม่',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'งานของฉัน',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'ประวัติ',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0,
                  ),
                ),
              )
            ],
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: MediaQuery.of(context).size.width,
              child: TabBarView(
                  controller: _tabController,
                  children: [Newjob() ,Book1(), History(), ]),
            ),
          )
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
            work(),
            messageMenu(),
            profileMenu(),
            logOut()
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
  ListTile work() {
    return ListTile(
      leading: Icon(
        Icons.book,
        color: Colors.blue,
      ),
      title: Text(
        'MY JOB',
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
            MaterialPageRoute(builder: (value) => ProDetail1());
        Navigator.push(context, route);
      },
    );
  }

  ListTile logOut() {
    return ListTile(
      leading: Icon(
        Icons.exit_to_app,
        color: Colors.blue,
      ),
      title: Text(
        'SIGN OUT',
        style: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Login());
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
