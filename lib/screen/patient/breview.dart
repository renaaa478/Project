import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projectapp/model/getPatient.dart';
import 'package:projectapp/model/getbook.dart';
import 'package:projectapp/screen/patient/showcomment.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'advices.dart';
import 'comment.dart';
class ReviewBook extends StatefulWidget {
  ReviewBook({Key key}) : super(key: key);

  @override
  _ReviewBookState createState() => _ReviewBookState();
}

class _ReviewBookState extends State<ReviewBook> {
  String nameN, surN, bid, nid, pid, nameUser, surname, username;
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
          pid = getPatient.pId;
          readBook();
        }
      }
    } catch (e) {}
  }

  Future<Null> readBook() async {
    String url =
        '${MyCostant().domain}/care/app/bookreview.php?isAdd=true&pid=$pid';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: getallBooks.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Container(
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
                      Text('ประเภทบริการ : ${getallBooks[index].nameSer}'),
                      Text(
                          'ผู้ดูแล : ${getallBooks[index].nName}   ${getallBooks[index].nSername}'),
                      Text('ประเภทผู้ดูแล : ${getallBooks[index].nnName}'),
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
                            Text(getallBooks[index].nName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                            Text((' '),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                            Text(getallBooks[index].nSername,
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
                            Text(getallBooks[index].bFee,
                                style: TextStyle(color: Colors.blueGrey)),
                            Text(' บาท',
                                style: TextStyle(color: Colors.blueGrey)),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: FlatButton(
                            onPressed: () {
                              nameN = getallBooks[index].nName;
                              surN = getallBooks[index].nSername;
                              bid = getallBooks[index].bId;
                              MaterialPageRoute route = MaterialPageRoute(
                                builder: (value) => AdviceP(
                                  bid: bid,
                                  nmaeN: nameN,
                                  surN: surN,
                                ),
                              );
                              Navigator.push(context, route)
                                  .then((value) => null);
                            },
                            color: Colors.red[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text("Advice",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.0, vertical: 3.0),
                          child: FlatButton(
                            onPressed: () {
                              nameN = getallBooks[index].nName;
                              surN = getallBooks[index].nSername;
                              bid = getallBooks[index].bId;
                              nid = getallBooks[index].nId;
                              pid = getallBooks[index].pId;
                              checkcomment();
                            },
                            color: Colors.red[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text("Comment",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
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
   Future<Null> checkcomment() async {
    String url =
        '${MyCostant().domain}/care/app/comment.php?bid=$bid';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
    
      print('result = $result');
      if (result == null) {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (value) => Comment1(
            bid: bid,
            nmaeN: nameN,
            surN: surN,
            nid: nid,
            pid: pid,
          ),
        );
        Navigator.push(context, route);
      } else {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (value) => Showcom(
            nmaeN: nameN,
            surN: surN,
            bid: bid,
            nid: nid,
            pid: pid,
          ),
        );
        Navigator.push(context, route);
      }
    } catch (e) {}
  }
}