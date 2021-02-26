import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:projectapp/screen/patient/editProfile.dart';
import 'package:projectapp/screen/patient/patientMain.dart';
import 'package:projectapp/screen/patient/profile1.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projectapp/screen/patient/service.dart';
import 'calender.dart';

class ProDetail extends StatefulWidget {
  ProDetail({Key key}) : super(key: key);

  @override
  _ProDetailState createState() => _ProDetailState();
}

class _ProDetailState extends State<ProDetail> {
  String nameUser, surname, username, age, email, phone, sex, birth, con, id,adds;
  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString('pid');
      nameUser = preferences.getString('pname');
      surname = preferences.getString('psurname');
      username = preferences.getString('user');
      email = preferences.getString('pemail');
      phone = preferences.getString('pphone');
      age = preferences.getString('page');
      sex = preferences.getString('psex');
      birth = preferences.getString('pb');
      con = preferences.getString('pcon');
      adds = preferences.getString('padd');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
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
                decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey,width: 3),
                shape: BoxShape.circle,
                image: DecorationImage(fit: BoxFit.cover,
                  image: AssetImage('images/pro.jpg'))),
                  ),
                  // Image(
                  //   width: 100,
                  //   height: 100,
                  //   fit: BoxFit.cover,
                    
                  //   alignment: Alignment.topLeft,
                  //   image: NetworkImage(
                  //       "https://www.nursingworld.org/~4adc9e/globalassets/social-networking-principles-toolkit/largeimage-anais-20.jpg"),
                  // ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Padding(padding: EdgeInsets.only(left: 40.0)),
                      Text(
                        'ชื่อ - สกุล:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight:FontWeight.bold,
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
                        'Address:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight:FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$adds',
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
                          fontWeight:FontWeight.bold,
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
                          fontWeight:FontWeight.bold,
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
                          fontWeight:FontWeight.bold,
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
                          fontWeight:FontWeight.bold,
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
                          fontWeight:FontWeight.bold,
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
                   Padding(padding: EdgeInsets.only(top: 9)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Padding(padding: EdgeInsets.only(left: 40.0)),
                      Text(
                        'โรคประจำตัว:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight:FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$con',
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
      ),drawer: showDrawer(),
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
                  EditProfile(),
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
            homebook(),
            calenderMenu(),
            mybook(),
            profileMenu()
          ],
        ),
      );

  ListTile homeMenu() {
    return ListTile(
      leading: Icon(Icons.home, color: Colors.lightBlue),
      title: Text('HOME'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Home1());
        Navigator.push(context, route);
      },
    );
  }

  ListTile homebook() {
    return ListTile(
      leading: Icon(Icons.book,
      color: Colors.lightBlue,),
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
      leading: Icon(Icons.calendar_today, color: Colors.lightBlue),
      title: Text('CALENDAR'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Calender());
        Navigator.push(context, route);
      },
    );
  }

 ListTile mybook() {
    return ListTile(
      leading: Icon(Icons.book,color: Colors.lightBlue),
      title: Text('My booking'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Profile1());
        Navigator.push(context, route);
      },
    );
  }

  ListTile profileMenu() {
    return ListTile(
      leading: Icon(Icons.person, color: Colors.lightBlue),
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

