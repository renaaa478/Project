import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectapp/model/allnurse.dart';
import 'package:projectapp/screen/login.dart';
import 'package:projectapp/screen/patient/profile1.dart';
import 'package:projectapp/screen/patient/service.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home1 extends StatefulWidget {
  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  String nameUser, surname, username;
  List<GetAllNurse> getallNurses = List();
  // bool status = true;
  @override
  void initState() {
    super.initState();
    findUser();
    readNurse();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('name');
      surname = preferences.getString('sername');
      username = preferences.getString('user');
    });
    
  }

  Future<Null> readNurse() async {
    String url = '${MyCostant().domain}/care/app/getAllNurse.php?isAdd=true';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      if (result.toString() != null) {
        for (var map in result) {
          GetAllNurse getAllNurse = GetAllNurse.fromJson(map);
          setState(() {
            getallNurses.add(getAllNurse);
          });
        }
      } else {
        Text('ไม่มีข้อมูล');
      }
      // for (var map in result) {
      //   GetPatient getPatient = GetPatient.fromJson(map);
      //   if (getPatient.pUsername != null) {
      //     routeTuService(ProDetail(), getPatient);
      //   }
      // }

    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameUser == null ? 'HOME' : '$nameUser $surname'),
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(Icons.exit_to_app),
        //       onPressed: () {
        //         MaterialPageRoute route =
        //             MaterialPageRoute(builder: (value) => Login());
        //         Navigator.pushAndRemoveUntil(context, route, (route) => false);
        //       })
        // ],
      ),
      body:

          // SizedBox(
          //   // width: MediaQuery.of(context).size.width * 0.45,
          //   child: TextFormField(
          //     decoration: InputDecoration(
          //       suffixIcon: Icon(Icons.search),
          //       labelText: "Search..",
          //       enabledBorder: OutlineInputBorder(
          //           borderSide: BorderSide(color: MyStyle().darkColor)),
          //       focusedBorder: OutlineInputBorder(
          //           borderSide: BorderSide(color: MyStyle().primaryColor)),
          //     ),
          //   ),
          // ),
          Container(margin: EdgeInsets.only(top: 80),
          
            child: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
            InkWell(onTap: () {
               Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Home1());
        Navigator.push(context, route);
            },
                          child: Card(
                color: Colors.blue,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.home,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 150, left: 70),
                      child: Text(
                        "HOME",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(onTap: () {
               Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Service());
        Navigator.push(context, route);
            },
                          child: Card(
                color: Colors.blue,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.book,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                     Container(
                      margin: EdgeInsets.only(top: 150, left: 70),
                      child: Text(
                        "SERVICE",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(onTap: () {
               Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Profile1());
        Navigator.push(context, route);
            },
                          child: Card(
                color: Colors.blue,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.account_circle,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                     Container(
                      margin: EdgeInsets.only(top: 150, left: 70),
                      child: Text(
                        "PROFILE",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(onTap: () {
               Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Login());
        Navigator.push(context, route);
            },
                          child: Card(
                color: Colors.blue,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.exit_to_app,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                     Container(
                      margin: EdgeInsets.only(top: 150, left: 70),
                      child: Text(
                        "EXIT",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
          ),

      // Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Container(
      //     child: FittedBox(
      //       child: Material(
      //         color: Colors.white,
      //         elevation: 5.0,
      //         borderRadius: BorderRadius.circular(10.0),
      //         shadowColor: Color(0x80219683),
      //         child: Row(
      //           children: <Widget>[
      //             Container(
      //               child: Text("Name Surname",
      //                   style: TextStyle(
      //                     fontSize: 8.0,
      //                   )),
      //             ),
      //             Container(
      //               width: 100,
      //               height: 50,
      //               child: InkWell(
      //                 onTap: () {
      //                   MaterialPageRoute route = MaterialPageRoute(
      //                       builder: (value) => Ndetail());
      //                   Navigator.push(context, route);
      //                 },
      //                 child: ClipRRect(
      //                   borderRadius: new BorderRadius.circular(10.0),
      //                   child: Image(
      //                     fit: BoxFit.contain,
      //                     alignment: Alignment.topRight,
      //                     image: NetworkImage(
      //                         "https://undubzapp.com/wp-content/uploads/2019/05/1-1-1.jpg"),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),

      // drawer: showDrawer(),
    );
  }

  // Drawer showDrawer() => Drawer(
  //       child: ListView(
  //         children: <Widget>[
  //           showHead(),
  //           homeMenu(),
  //           homebook(),
  //           calenderMenu(),
  //           // messageMenu(),
  //           profileMenu()
  //         ],
  //       ),
  //     );

  // ListTile homeMenu() {
  //   return ListTile(
  //     leading: Icon(Icons.home),
  //     title: Text('HOME'),
  //     onTap: () {
  //       Navigator.pop(context);
  //       MaterialPageRoute route =
  //           MaterialPageRoute(builder: (value) => Home1());
  //       Navigator.push(context, route);
  //     },
  //   );
  // }

  // ListTile homebook() {
  //   return ListTile(
  //     leading: Icon(Icons.book),
  //     title: Text('SERVICE'),
  //     onTap: () {
  //       Navigator.pop(context);
  //       MaterialPageRoute route =
  //           MaterialPageRoute(builder: (value) => Service());
  //       Navigator.push(context, route);
  //     },
  //   );
  // }

  // ListTile calenderMenu() {
  //   return ListTile(
  //     leading: Icon(Icons.calendar_today),
  //     title: Text('CALENDAR'),
  //     onTap: () {
  //       Navigator.pop(context);
  //       MaterialPageRoute route =
  //           MaterialPageRoute(builder: (value) => Calender());
  //       Navigator.push(context, route);
  //     },
  //   );
  // }

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

  // ListTile profileMenu() {
  //   return ListTile(
  //     leading: Icon(Icons.person),
  //     title: Text('PROFILE'),
  //     onTap: () {
  //       Navigator.pop(context);
  //       MaterialPageRoute route =
  //           MaterialPageRoute(builder: (value) => Profile1());
  //       Navigator.push(context, route);
  //     },
  //   );
  // }

  // UserAccountsDrawerHeader showHead() {
  //   return UserAccountsDrawerHeader(
  //       decoration: MyStyle().boxDecoration('paa.jpg'),
  //       // currentAccountPicture: MyStyle().showLogo(),
  //       accountName: Text('Name'),
  //       accountEmail: Text('xxxxx'));
  // }
}
