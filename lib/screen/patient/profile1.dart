import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:projectapp/model/getPatient.dart';
import 'package:projectapp/screen/patient/bookConfirm.dart';
import 'package:projectapp/screen/patient/booked.dart';
import 'package:projectapp/screen/patient/breview.dart';
import 'package:projectapp/screen/patient/calender.dart';
import 'package:projectapp/screen/patient/payment.dart';
import 'package:projectapp/screen/patient/prodetail.dart';
import 'package:projectapp/screen/patient/service.dart';
import 'package:flutter/material.dart';
import 'package:projectapp/screen/patient/patientMain.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';

class Profile1 extends StatefulWidget {
  Profile1({Key key, String username}) : super(key: key);

  @override
  _Profile1State createState() => _Profile1State();
}

class _Profile1State extends State<Profile1>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String nameUser, surname, username;
  @override
  void initState() {
    super.initState();
    findUser();

    _tabController = TabController(length: 4, vsync: this);
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
        '${MyCostant().domain}/care/app/getPatient.php?isAdd=true&P_username=$username';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      for (var map in result) {
        GetPatient getPatient = GetPatient.fromJson(map);
        if (getPatient.pUsername != null) {
          routeTuService(ProDetail(), getPatient);
        }
      }
    } catch (e) {}
  }

  Future<Null> routeTuService(Widget myWidget, GetPatient getPatient) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('pid', getPatient.pId);
    preferences.setString('pname', getPatient.pName);
    preferences.setString('psurname', getPatient.pSername);
    preferences.setString('pemail', getPatient.pEmail);
    preferences.setString('pphone', getPatient.pPhone);
    preferences.setString('page', getPatient.pAge);
    preferences.setString('psex', getPatient.sex);
    preferences.setString('pb', getPatient.pBirth);
    preferences.setString('pcon', getPatient.pCon);
    preferences.setString('padd', getPatient.pAdd);
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
        padding: EdgeInsets.only(left: 20.0),
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
                      fit: BoxFit.cover, image: AssetImage('images/pro.jpg'))),
              // alignment: Alignment.center,
              // child: Image.asset('images/nurse.jpg')

              // image: NetworkImage('https://www.nursingworld.org/~4adc9e/globalassets/social-networking-principles-toolkit/largeimage-anais-20.jpg')
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
            labelPadding: EdgeInsets.only(right: 30.0),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                child: Text(
                  ' รอการยืนยัน',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  ' ชำระเงิน',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'จองสำเร็จ',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  ' รีวิว',
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 21.0,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height - 50.0,
            width: double.infinity,
            child: TabBarView(
                controller: _tabController,
                children: [BookConfirm(), Pay(), Booked(), ReviewBook()]),
          ),
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
            homebook(),
            calenderMenu(),
            mybook(),
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

  
  ListTile mybook() {
    return ListTile(
      leading: Icon(Icons.book),
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
      leading: Icon(Icons.person),
      title: Text('PROFILE'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => ProDetail());
        Navigator.push(context, route);
      },
    );
  }

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
        decoration: MyStyle().boxDecoration('paa.jpg'),
        // currentAccountPicture: MyStyle().showLogo(),
        accountName: Text(nameUser),
        accountEmail: Text('xxxxx'));
  }
}
