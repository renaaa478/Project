import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projectapp/model/comment.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:http/http.dart' as http;

class ReviewN extends StatefulWidget {
  final String nidd;
  ReviewN({Key key, this.nidd}) : super(key: key);

  @override
  _ReviewNState createState() => _ReviewNState();
}

class _ReviewNState extends State<ReviewN> {
  String nid, comm;
  List<Getcomment> getallcoms = List();
  @override
  void initState() {
    super.initState();
    nid = "${widget.nidd}";
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
    return Scaffold(
      appBar: AppBar(
        title: Text('REVIEW'),
      ),
      body: Container(
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
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 20.0)),
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
                              children: [
                                Padding(padding: EdgeInsets.only(left: 30.0)),
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
                          children: [
                            Padding(padding: EdgeInsets.only(left: 0.0)),
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
      ),
    );
  }
}
