import 'package:flutter/material.dart';
import 'package:projectapp/screen/nurse/editProfile.dart';
import 'package:projectapp/screen/nurse/profilen.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';
import 'calendar.dart';
import 'comment.dart';
import 'home.dart';

class ProDetail1 extends StatefulWidget {
  ProDetail1({Key key}) : super(key: key);

  @override
  _ProDetail1State createState() => _ProDetail1State();
}

class _ProDetail1State extends State<ProDetail1> {
  String nameUser, surname, username, age, email, phone, sex, birth, h, w, type,add;
  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('nname');
      surname = preferences.getString('nsurname');
      username = preferences.getString('username');
      email = preferences.getString('nemail');
      phone = preferences.getString('nphone');
      age = preferences.getString('nage');
      sex = preferences.getString('nsex');
      birth = preferences.getString('nb');
      h = preferences.getString('nhight');
      w = preferences.getString('nweight');
      type = preferences.getString('type');
      add = preferences.getString('Nadd');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: showDrawer(),
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: <Color>[Colors.white, MyStyle().primaryColor],
          center: Alignment(0, -0.3),
          radius: 3.5,
        )),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 40,
            ),
            child: Form(
              child: Column(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey, width: 3),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/nurse.jpg'))),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Padding(padding: EdgeInsets.only(left: 40.0)),
                      Text(
                        'ชื่อ - สกุล:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$nameUser $surname',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 9)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Padding(padding: EdgeInsets.only(left: 40.0)),
                      Text(
                        'Type:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$type',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 9)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Padding(padding: EdgeInsets.only(left: 40.0)),
                      Text(
                        'Height:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$h  cm  ',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        'Weight:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$w kg',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 9)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Padding(padding: EdgeInsets.only(left: 40.0)),
                      Text(
                        'Address:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$add',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 9)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Padding(padding: EdgeInsets.only(left: 40.0)),
                      Text(
                        'Sex:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$sex',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 9)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Padding(padding: EdgeInsets.only(left: 40.0)),
                      Text(
                        'Birthday:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$birth',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 9)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Padding(padding: EdgeInsets.only(left: 40.0)),
                      Text(
                        'Age:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$age year old',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 9)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Padding(padding: EdgeInsets.only(left: 40.0)),
                      Text(
                        'Emali:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$email',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                   Padding(padding: EdgeInsets.only(top: 9)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Padding(padding: EdgeInsets.only(left: 40.0)),
                      Text(
                        'Phone:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$phone',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  editButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row editButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () => rountInfo(
                  EditProfilen(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void rountInfo(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.push(context, route);
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
