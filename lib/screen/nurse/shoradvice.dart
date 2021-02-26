import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projectapp/model/getadvice.dart';
import 'package:projectapp/model/getbook.dart';
import 'package:http/http.dart' as http;
import 'package:projectapp/screen/nurse/editAdvice.dart';
import 'package:projectapp/screen/nurse/prodetailn.dart';
import 'package:projectapp/screen/nurse/profilen.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:projectapp/utility/normal_dialog.dart';
import 'package:projectapp/utility/server.dart';

import '../login.dart';
import 'calendar.dart';
import 'comment.dart';
import 'home.dart';

class Showadvice extends StatefulWidget {
  final String id, nameP, surP, nid, pid, nameN, surN, advice;
  Showadvice(
      {Key key,
      this.id,
      this.nameP,
      this.surP,
      this.nid,
      this.pid,
      this.nameN,
      this.surN,
      this.advice})
      : super(key: key);

  @override
  _ShowadviceState createState() => _ShowadviceState();
}

class _ShowadviceState extends State<Showadvice> {
  GetBook getBook;
  GetAdvice getAdvice;
  String bid, name, surname, advice, nid, pid, nameN, surN, advices;
  @override
  void initState() {
    super.initState();
    bid = "${widget.id}";
    readAdvice();
  }

  Future<Null> readAdvice() async {
    String url =
        '${MyCostant().domain}/care/app/advice.php?isAdd=true&Bid=$bid';
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
            getAdvice = GetAdvice.fromJson(map);
            advice = getAdvice.advice;
          });
        }
        advice = getAdvice.advice;
      }
    } catch (e) {}
  }
  // Future<Null> readBook() async {
  //   String url =
  //       '${MyCostant().domain}/care/app/bookjoinP.php?isAdd=true&bid=$bid';
  //   try {
  //     final http.Response response = await http.Client().get(
  //       url,
  //     );
  //     print('res = $response');
  //     var result = json.decode(response.body);
  //     print('result = $result');

  //     if (result.toString() != null) {
  //       for (var map in result) {
  //         GetBook getBook = GetBook.fromJson(map);
  //         print(getBook);
  //       }
  //     } else {
  //       Text('ไม่มีข้อมูล');
  //     }
  //   } catch (e) {}
  // }

  @override
  Widget build(BuildContext context) {
    bid = "${widget.id}";
    name = "${widget.nameP}";
    surname = "${widget.surP}";
    nid = "${widget.nid}";
    pid = "${widget.pid}";
    nameN = "${widget.nameN}";
    surN = "${widget.surN}";
    // name = "${getBook.pName}";
    // surname = "${getBook.pSername}";
    return Scaffold(
        appBar: AppBar(
          title: Text('ADVICE'),
        ),
        drawer: showDrawer(),
        body: Container(
           decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: <Color>[Colors.white, MyStyle().primaryColor],
          center: Alignment(0, -0.3),
          radius: 3.5,
        )),
            child: ListView(
                padding: EdgeInsets.only(left: 0.0, top: 40.0),
                children: <Widget>[
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey, width: 3),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/nurse.jpg'))),
                  ),
                  Text(
                    '$name $surname',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 50.0)),
              Card(
                
                color: Colors.white,
                elevation: 5.0,
                
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Container(
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          'คำแนะนำ :  $advice',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          ' ',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            //  editbutton()
            ])));
  }

  // Row editbutton() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: [
  //       Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Container(
  //             margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
  //             child: FloatingActionButton(
  //               child: Icon(Icons.edit),
  //               onPressed: () => rountInfo(Editadvice(
  //                  id: bid,
  //             nameP: name,
  //             nid: nid,
  //             surP: surname,
  //             nameN :nameN,
  //             surN:surN,
  //             advice : advice,
  //               )
  //                 ,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
void rountInfo(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.push(context, route);
  }
  Future<Null> addAdvice(http.Client client, var json) async {
    try {
      final response = await client.post(Server().addAdvice,
          headers: {"Content-Type": "application/json"}, body: json);
      print('res1 = ${response.body}');
      var getData = jsonDecode(response.body);
      print(getData['status']);
      if (getData['status'] == 'true') {
        MyStyle().ShowProgess();
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Showadvice());
        Navigator.push(context, route);
        normalDialog(context, 'เพิ่มคำแนะนำสำเร็จ');
      }
    } catch (e) {}
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
