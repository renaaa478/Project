import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projectapp/model/getadvice.dart';

import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:http/http.dart' as http;

class AdviceP extends StatefulWidget {
  final String bid, nmaeN, surN;

  AdviceP({Key key, @required this.bid, this.nmaeN, this.surN})
      : super(key: key);

  @override
  _AdvicePState createState() => _AdvicePState();
}

class _AdvicePState extends State<AdviceP> {
  String nmaN, bid, surN, advice;
  GetAdvice getAdvice;
  @override
  void initState() {
    bid = "${widget.bid}";
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

  @override
  Widget build(BuildContext context) {
    bid = "${widget.bid}";
    nmaN = "${widget.nmaeN}";
    surN = "${widget.surN}";
    return Scaffold(
        appBar: AppBar(
          title: Text('Advice'),
        ),
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
                            border:
                                Border.all(color: Colors.blueGrey, width: 3),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('images/nurse.jpg'))),
                      ),
                      Text(
                        '$nmaN  $surN',
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
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: Container(
                      child: ListTile(
                        title: Row(
                          children: [
                            Text(
                              'คำแนะนำ : $advice',
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
                ])));
  }
}
