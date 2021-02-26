import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projectapp/model/getadvice.dart';
import 'package:projectapp/model/getbook.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:http/http.dart' as http;
import 'package:projectapp/utility/normal_dialog.dart';

class Editadvice extends StatefulWidget {
  final String id, nameP, surP, nid, pid, nameN, surN, advice;
  Editadvice(
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
  _EditadviceState createState() => _EditadviceState();
}

class _EditadviceState extends State<Editadvice> {
  GetBook getBook;
  GetAdvice getAdvice;
  String bid, name, surname, advice, nid, pid, nameN, surN;
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
        print(advice);
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
          title: Text('แก้ไขคำแนะนำ'),
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
                  child: TextFormField(
                    onChanged: (value) => advice = value.trim(),
                    initialValue: advice,
                    // keyboardType: TextInputType.multiline,
                    // minLines: 8,
                    // maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'นามสกุล'),
                    // decoration: InputDecoration(
                    //   // hintText: 'advice',
                    //   // hintStyle: TextStyle(color: Colors.grey),
                    //   border: OutlineInputBorder(
                    //     borderSide: BorderSide(color: Colors.grey),
                    //     borderRadius: BorderRadius.all(Radius.circular(20.0)),
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

  void addAdvice(client, String json) {}
}
