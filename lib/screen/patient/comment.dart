import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectapp/screen/patient/showcomment.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:projectapp/utility/normal_dialog.dart';
import 'package:projectapp/utility/server.dart';

class Comment1 extends StatefulWidget {
  final String bid, nmaeN, surN, nid, pid;
  Comment1(
      {Key key, @required this.bid, this.nmaeN, this.surN, this.nid, this.pid})
      : super(key: key);

  @override
  _Comment1State createState() => _Comment1State();
}

class _Comment1State extends State<Comment1> {
  String comment, nameN, surN, bid, nid, pid;
  @override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bid = "${widget.bid}";
    nameN = "${widget.nmaeN}";
    surN = "${widget.surN}";
    nid = "${widget.nid}";
    pid = "${widget.pid}";
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment'),
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
                    '$nameN $surN',
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
                  onChanged: (value) => comment = value.trim(),
                  keyboardType: TextInputType.multiline,
                  minLines: 4,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'comment',
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
                        if (comment == null || comment.isEmpty) {
                          normalDialog(context,
                              'กรุณาแสดงความคิดห็นในการบริการของคุณ $nameN $surN');
                        } else {
                          Map<String, dynamic> _map = {
                            "N_id": nid,
                            "P_id": pid,
                            "B_id": bid,
                            "comment": comment,
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
      ),
    );
  }

  Future<Null> addAdvice(http.Client client, var json) async {
    try {
      final response = await client.post(Server().addComment,
          headers: {"Content-Type": "application/json"}, body: json);
      print('res1 = ${response.body}');
      var getData = jsonDecode(response.body);
      print(getData['status']);
      if (getData['status'] == 'true') {
        MyStyle().ShowProgess();
        MaterialPageRoute route = MaterialPageRoute(
            builder: (value) => Showcom(
                  bid: bid,
                  nid: nid,
                  pid: pid,
                  com: comment,
                ));
        Navigator.push(context, route);
        normalDialog(context, 'เพิ่มความคิดเห็นสำเร็จ');
      }
    } catch (e) {}
  }
}
