import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projectapp/model/comment.dart';
import 'package:projectapp/screen/patient/patientMain.dart';
import 'package:projectapp/screen/patient/profile1.dart';
import 'package:projectapp/screen/patient/service.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:http/http.dart' as http;

import 'calender.dart';

class Showcom extends StatefulWidget {
  final String bid, nid, pid, com,nmaeN,surN;
  Showcom({Key key, this.bid, this.com, this.nid, this.pid,this.nmaeN,this.surN}) : super(key: key);

  @override
  _ShowcomState createState() => _ShowcomState();
}

class _ShowcomState extends State<Showcom> {
  String nid, comm, nameN,surN;

  List<Getcomment> getallcoms = List();
  @override
  void initState() {
    super.initState();
    nid = "${widget.nid}";
    print(nid);
    readCom();
  
  }

  Future<Null> readCom() async {
    String url =
        '${MyCostant().domain}/care/app/getAllcom.php?isAdd=true&nid=$nid';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      if (result != null) {
        for (var map in result) {
          setState(() {
            print('map =  $map');
            Getcomment getcomment = Getcomment.fromJson(map);
            comm = getcomment.cCom;
            setState(() {
              getallcoms.add(getcomment);
            });
          });
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    nameN ="${widget.nmaeN}";
    surN ="${widget.surN}";
    return Scaffold(
      appBar: AppBar(
        title: Text('COMMENT $nameN  $surN'),
      ),
      body: Container(
        child:
      Container(
        
        child: ListView.builder(
          itemCount: getallcoms.length,
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
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    
                    Column(
                      children: [Padding(padding: EdgeInsets.only(top: 20.0)),
                        Row(
                          children: [
                            Container(
                              width: 40.0,
                              height: 40.0,
                              color: Colors.blue[200],
                              child: CircleAvatar(
                                backgroundColor: Colors.blue[100],
                                foregroundColor: Colors.blue[100],
                                backgroundImage: NetworkImage(
                                    "https://www.nursingworld.org/~4adc9e/globalassets/social-networking-principles-toolkit/largeimage-anais-20.jpg"),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Padding(padding: EdgeInsets.only(left: 30.0)),
                                Text(getallcoms[index].pName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                Text('   '),
                                Text(getallcoms[index].pSername,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                        Text('      '),
                                        Text(getallcoms[index].cDate,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [Padding(padding: EdgeInsets.only(left:0.0 )),
                            Text(comm,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal)),
                           
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 20.0)),
                      ],
                    ),

                   
                    
                  ],
                ),
                //  widget(child: Container(alignment: Alignment.center,))
              ),
            ),
          ),
        ),
      ),),
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
        Navigator.push(context, route);
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
