import 'package:flutter/material.dart';
import 'package:projectapp/screen/patient/calender.dart';
import 'package:projectapp/screen/patient/caretakerList_hos.dart';
import 'package:projectapp/screen/patient/nurseList.dart';
import 'package:projectapp/screen/patient/patientMain.dart';
import 'package:projectapp/screen/patient/prodetail.dart';
import 'package:projectapp/screen/patient/profile1.dart';
import 'package:projectapp/utility/mystyle.dart';

class Service extends StatefulWidget {
  Service({Key key, String username}) : super(key: key);

  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  String ser, serget;


  @override
  Widget build(BuildContext context) {
    ser = "Go to hospital";
    serget = "Get medecine";
    return Scaffold(
      appBar: AppBar(
        title: Text('Service'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: FittedBox(
                child: Material(
                  color: Colors.blue[50],
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10.0),
                  shadowColor: Color(0x80219683),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: new EdgeInsets.all(5.0),
                        child: Text("Go to hospital",
                            style: TextStyle(
                              fontSize: 8.0,
                            )),
                      ),
                      Container(
                          width: 100,
                          height: 50,
                          child: InkWell(
                            onTap: () {
                              MaterialPageRoute route = MaterialPageRoute(
                                  builder: (value) => NurseListhos(ser1: ser));
                              Navigator.push(context, route);
                            },
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(10.0),
                              child: Container(
                                
                                  alignment: Alignment.center,
                                child: Image.asset('images/hos.jpg',width: 100,
                                  height:100,fit: BoxFit.cover,
                                  alignment: Alignment.topLeft,)
                                  
                                 
                                 
                                //   image: NetworkImage(
                                //       "https://www.bangkokrayong.com/assets/images/about/832x451.jpg"),
                                // ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: FittedBox(
                child: Material(
                  color: Colors.blue[50],
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10.0),
                  shadowColor: Color(0x80219683),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: new EdgeInsets.all(5.0),
                        child: Text("Get Medicine",
                            style: TextStyle(
                              fontSize: 8.0,
                            )),
                      ),
                      Container(
                          width: 100,
                          height: 50,
                          child: InkWell(
                            onTap: () {
                              MaterialPageRoute route = MaterialPageRoute(
                                  builder: (value) => NurseList(
                                        ser1: serget,
                                      ));
                              Navigator.push(context, route);
                            },
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(10.0),
                              child: Container(
                                width: 50,
                                  height: 100,
                                child: Image.asset('images/bb.jpg',fit: BoxFit.cover,
                                  alignment: Alignment.topLeft,)
                                  
                                  
                                //   image: NetworkImage(
                                //       "https://lh3.googleusercontent.com/OACtHZY-eDew1SfenP9u4xnNTU8fjPAWhcVLNZJlgLlfmb-LnYvfRQRnMKKvn1E376uDKNHO_SOotXlnFy_N7ek"),
                                // ),
                            ),
                              ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
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
        accountName: Text('Name'),
        accountEmail: Text('xxxxx'));
  }
}
