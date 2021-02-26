import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectapp/model/getNurse.dart';
import 'package:projectapp/model/getbook.dart';
import 'package:projectapp/screen/nurse/shoradvice.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String bid, nid, username, surname, nameUser, nameP, surnameP, pid;
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  List<GetBook> getallBooks = List();
  Future<Null> checkUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('name');
      surname = preferences.getString('sername');
      username = preferences.getString('user');
      print(username);
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
      for (var map in result) {
        GetNurse getNurse = GetNurse.fromJson(map);
        if (getNurse.user != null) {
          nid = getNurse.nId;
          readBook();
        }
      }
    } catch (e) {}
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('name');
      surname = preferences.getString('sername');
      username = preferences.getString('user');
      print(username);
    });
  }

  Future<Null> readBook() async {
    String url =
        '${MyCostant().domain}/care/app/historybook.php?isAdd=true&nid=$nid';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      if (result.toString() != null) {
        for (var map in result) {
          GetBook getBook = GetBook.fromJson(map);
          setState(() {
            getallBooks.add(getBook);
          });
        }
      } else {
        Text('ไม่มีข้อมูล');
      }
    } catch (e) {}
  }

  Future<Null> findAdvice() async {
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
        MaterialPageRoute route = MaterialPageRoute(
          builder: (value) => Showadvice(
            id: bid,
            nameP: nameP,
            surP: surnameP,
            nid: nid,
            pid: pid,
          ),
        );
        Navigator.push(context, route).then((value) => null);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    // print(username);
    return Scaffold(
        body: ListView.builder(
      itemCount: getallBooks.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => SimpleDialog(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'รายละเอียดการจอง',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(' '),
                      Text(
                          'ผู้ป่วย : ${getallBooks[index].pName}   ${getallBooks[index].pSername}'),
                      Text('โรคประจำตัว : ${getallBooks[index].pCon}'),
                      Text('วันที่ : ${getallBooks[index].bDateSer}'),
                      Text(
                          'เวลา : ${getallBooks[index].bTimesttr}.00 น. ถึง ${getallBooks[index].bTimeEnd}.00 น.'),
                      Text('ราคา : ${getallBooks[index].bFee} บาท'),
                    ],
                  ),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlineButton(
                          onPressed: () {
                            if (getallBooks[index].nId != null) {
                              Text('data');
                            }
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    Container(
                      width: 55.0,
                      height: 55.0,
                      color: Colors.blue[200],
                      child: CircleAvatar(
                        backgroundColor: Colors.blue[100],
                        foregroundColor: Colors.blue[100],
                        backgroundImage: NetworkImage(
                            "https://www.nursingworld.org/~4adc9e/globalassets/social-networking-principles-toolkit/largeimage-anais-20.jpg"),
                      ),
                    ),
                    SizedBox(width: 6.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(getallBooks[index].pName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                            Text((' '),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                            Text(getallBooks[index].pSername,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text(getallBooks[index].bDateSer,
                            style: TextStyle(color: Colors.blueGrey)),
                        Row(
                          children: [
                            Text('เวลา: ',
                                style: TextStyle(color: Colors.blueGrey)),
                            Text(getallBooks[index].bTimesttr,
                                style: TextStyle(color: Colors.blueGrey)),
                            Text('.00',
                                style: TextStyle(color: Colors.blueGrey)),
                            Text('ถึง'),
                            Text(getallBooks[index].bTimeEnd,
                                style: TextStyle(color: Colors.blueGrey)),
                            Text('.00',
                                style: TextStyle(color: Colors.blueGrey)),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15.0),
                          child: FlatButton(
                            onPressed: () {
                              bid = getallBooks[index].bId;
                              nameP = getallBooks[index].pName;
                              surnameP = getallBooks[index].pSername;
                              nid = getallBooks[index].nId;
                              pid = getallBooks[index].pId;
                              findAdvice();
                              // MaterialPageRoute route = MaterialPageRoute(
                              //   builder: (value) => Advice(
                              //     getbook: getallBooks[index],
                              //   ),
                              // );
                              // Navigator.push(context, route)
                              //     .then((value) => null);
                            },
                            color: Colors.red[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text("Advice",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        // Container(
                        //   alignment: Alignment.centerRight,
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 1.0, vertical: 3.0),
                        //   child: FlatButton(
                        //     onPressed: () {
                        //       MaterialPageRoute route = MaterialPageRoute(
                        //         builder: (value) => Home(),
                        //       );
                        //       Navigator.push(context, route);
                        //     },
                        //     color: Colors.red[200],
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20.0),
                        //     ),
                        //     child: Text("Comment",
                        //         style: TextStyle(color: Colors.white)),
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
                //  widget(child: Container(alignment: Alignment.center,))
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
