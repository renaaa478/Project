import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projectapp/model/getbook.dart';
import 'package:http/http.dart' as http;
import 'package:projectapp/screen/nurse/shoradvice.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:projectapp/utility/normal_dialog.dart';
import 'package:projectapp/utility/server.dart';

class Advice extends StatefulWidget {
  final String id, nameP, surP, nid, pid, nameN, surN;
  Advice(
      {Key key,
      this.id,
      this.nameP,
      this.surP,
      this.nid,
      this.pid,
      this.nameN,
      this.surN})
      : super(key: key);

  @override
  _AdviceState createState() => _AdviceState();
}

class _AdviceState extends State<Advice> {
  GetBook getBook;
  String bid, name, surname, advice, nid, pid, nameN, surN, ids;
  @override
  void initState() {
    super.initState();
    bid = "${widget.id}";
    readBook();
  }

  Future<Null> readBook() async {
    String url =
        '${MyCostant().domain}/care/app/bookjoinP.php?isAdd=true&bid=$bid';
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
          print(getBook);
          ids = getBook.sId;
        }
      } else {
        Text('ไม่มีข้อมูล');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    bid = "${widget.id}";
    name = "${widget.nameP}";
    surname = "${widget.surP}";
    nid = "${widget.nid}";
    pid = "${widget.pid}";
    nameN = "${widget.nameN}";
    surN = "${widget.surN}";
    return Scaffold(
        appBar: AppBar(
          title: Text('ADVICE'),
        ),
        body: Container(
          child: ListView(
              padding: EdgeInsets.only(left: 0.0, top: 20.0),
              children: <Widget>[
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
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
                Container(
                  width: 250.0,
                  height: 385.0,
                  child: TextField(
                    onChanged: (value) => advice = value.trim(),
                    keyboardType: TextInputType.multiline,
                    minLines: 8,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'advice',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 0.0)),
                Container(
                    width: 100.0,
                    child: RaisedButton(
                        color: MyStyle().darkColor,
                        onPressed: () {
                          if (advice == null || advice.isEmpty) {
                            normalDialog(context,
                                'กรุณาเพิ่มคำแนะนำใหเแก่คุณ $name  $surname');
                          } else {
                            Map<String, dynamic> _map = {
                              "N_id": nid,
                              "P_id": pid,
                              "B_id": bid,
                              "advice": advice,
                              "id_ser": ids,
                            };
                            var json = jsonEncode(_map);
                            addAdvice(http.Client(), json);
                          }
                        },
                        child: Text(
                          'Save Information',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        )))
              ]),
        ));
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
        MaterialPageRoute route = MaterialPageRoute(
            builder: (value) => Showadvice(
                  id: bid,
                  nameP: name,
                  nid: nid,
                  surP: surname,
                  nameN: nameN,
                  surN: surN,
                  advice: advice,
                ));
        Navigator.push(context, route);
        normalDialog(context, 'เพิ่มคำแนะนำสำเร็จ');
      }
    } catch (e) {}
  }
}
