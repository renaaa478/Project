import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projectapp/model/getIncome.dart';
import 'package:projectapp/model/getNurse.dart';
import 'package:projectapp/model/getbook.dart';
import 'package:projectapp/screen/login.dart';
import 'package:http/http.dart' as http;
import 'package:projectapp/screen/nurse/calendar.dart';
import 'package:projectapp/screen/nurse/comment.dart';
import 'package:projectapp/screen/nurse/prodetailn.dart';
import 'package:projectapp/screen/nurse/profilen.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String nameUser, surname, username, nid, bid, name, surname1;
  int sum = 0;
  GetNurse getNurse;
  GetBook getBook;
  List<GetIncome> getIncomes = List();
  List<GetBook> getbooks = List();
  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('name');
      surname = preferences.getString('sername');
      username = preferences.getString('user');
    });
    String url =
        '${MyCostant().domain}/care/app/getNurse.php?isAdd=true&user=$username';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      if (result != true) {
        for (var map in result) {
          GetNurse getNurse = GetNurse.fromJson(map);
          if (getNurse.user != null) {
            nid = getNurse.nId;
            print(nid);
            getIncom();
          }
        }
      }
    } catch (e) {}
  }

  Future<Null> readbook() async {
    String url = '${MyCostant().domain}/care/app/book1.php?isAdd=true&bid=$bid';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      for (var map in result) {
        GetBook getBook = GetBook.fromJson(map);
        name = getBook.pName;
        setState(() {
          getbooks.add(getBook);
        });
      }
    } catch (e) {}
  }

  Future<Null> getIncom() async {
    String url =
        '${MyCostant().domain}/care/app/getincome.php?isAdd=true&nid=$nid';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      for (var map in result) {
        GetIncome getIncome = GetIncome.fromJson(map);
        bid = getIncome.bId;
        readbook();
        setState(() {
          getIncomes.add(getIncome);
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < getIncomes.length; i++) {
      sum = sum + int.parse(getIncomes[i].price);
    }
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(nameUser == null ? 'HOME' : '$nameUser  $surname'),
      //   actions: <Widget>[
      //     IconButton(
      //         icon: Icon(Icons.exit_to_app),
      //         onPressed: () {
      //           MaterialPageRoute route =
      //               MaterialPageRoute(builder: (value) => Login());
      //           Navigator.pushAndRemoveUntil(context, route, (route) => false);
      //         })
      //   ],
      // ),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
         expandedHeight: 150,
          title: Text(nameUser == null ? 'HOME' : '$nameUser  $surname'),
          
          flexibleSpace: FlexibleSpaceBar(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: Text(
                        '  BALANCE',
                      )),
                      Container(child: Text('     $sum Baht')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate(<Widget>[
          SingleChildScrollView(
            child: ListView.builder(
              itemCount: getIncomes.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) => Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 80.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        SizedBox(width: 6.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 50.0)),
                                    Text(getIncomes[index].price,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold)),
                                    Text((' '),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold)),
                                    Text('Baht',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 50.0)),
                                        Text(getIncomes[index].bDate,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.normal)),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(getbooks[index].pName),
                              ],
                            ),
                          ],
                        ),
                        // Text('$name $surname1'),
                      ],
                    ),
                    //  widget(child: Container(alignment: Alignment.center,))
                  ),
                ),
              ),
            ),
          ),
        ]))
      ]),

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
