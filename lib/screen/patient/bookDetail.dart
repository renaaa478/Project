import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projectapp/model/getservice.dart';
import 'package:projectapp/model/typecare.dart';
import 'package:projectapp/model/typrser.dart';
import 'package:projectapp/screen/patient/profile1.dart';
import 'package:projectapp/screen/patient/service.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:projectapp/utility/normal_dialog.dart';
import 'package:projectapp/utility/server.dart';

class Bdetail extends StatefulWidget {
  final String nid,
      sid,
      pid,
      status,
      timeS,
      timeE,
      hospital,
      date,
      name,
      surname,
      ser,
      nnid,
      fee;

  Bdetail(
      {Key key,
      @required this.nid,
      this.date,
      this.hospital,
      this.pid,
      this.sid,
      this.status,
      this.timeE,
      this.timeS,
      this.name,
      this.ser,
      this.surname,
      this.nnid,
      this.fee})
      : super(key: key);

  @override
  _BdetailState createState() => _BdetailState();
}

class _BdetailState extends State<Bdetail> {
  GetService getService;
  int charge, sertime;
  var tt, scharge;
  String nid,
      sid,
      pid,
      status,
      timeS,
      timeE,
      hospital,
      date,
      name,
      surname,
      ser,
      charge1,
      nnid,
      fee;
  @override
  void initState() {
    super.initState();
    sid = widget.sid;
    print(sid);
    service();
  }

  Future<Null> service() async {
    String url =
        '${MyCostant().domain}/care/app/getservice.php?isAdd=true&idser=$sid';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      for (var map in result) {
        GetServices getServices = GetServices.fromJson(map);
        charge1 = getServices.charge;
        nurse();
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    nid = "${widget.nid}";
    nnid = "${widget.nnid}";
    sid = "${widget.sid}";
    pid = "${widget.pid}";
    status = "${widget.status}";
    timeE = "${widget.timeE}";
    timeS = "${widget.timeS}";
    hospital = "${widget.hospital}";
    date = "${widget.date}";
    name = "${widget.name}";
    surname = "${widget.surname}";
    ser = "${widget.ser}";
    fee = "${widget.fee}";
    tt = double.parse(timeE) - double.parse(timeS);
    return Scaffold(
        appBar: AppBar(
          title: Text("Book Detail"),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 5,
                top: 40,
              ),
              child: Form(
                child: Column(
                  children: [
                     Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage('images/nurse.jpg'))),
              // alignment: Alignment.center,
              // child: Image.asset('images/nurse.jpg')

              // image: NetworkImage('https://www.nursingworld.org/~4adc9e/globalassets/social-networking-principles-toolkit/largeimage-anais-20.jpg')
            ),
                    Row(
                      children: [
                        
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Text(' '),
                        Text(
                          surname,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Date:   ',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 9)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Service:   ',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          ser,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 9)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Time:   ',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          timeS,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text('     '),
                        Text(
                          'To   ',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          timeE,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 9)),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       'Adress:   ',
                    //       style: TextStyle(
                    //         fontSize: 18.0,
                    //       ),
                    //     ),
                    //     Text(
                    //       'xxxxxxxxxx',
                    //       style: TextStyle(
                    //         fontSize: 18.0,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Padding(padding: EdgeInsets.only(top: 9)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Hospital:   ',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          hospital,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 9)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Price:   ',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          fee,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.more),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => SimpleDialog(
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'รายละเอียดค่าบริการ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('ค่าบริการเริ่มต้น : $charge1 บาท'),
                                      Text('ค่าบริการ/ชม. : $scharge บาท'),
                                      Text(' จำนวน : $tt  ชั่วโมง'),
                                      Text('รวม: $fee บาท'),
                                    ],
                                  ),
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        OutlineButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('OK'),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            })
                      ],
                    ),
                    RaisedButton(
                        onPressed: () {
                          // var idser = int.parse(sid);
                          // var time1 = double.parse(timeS);
                          // var time2 = double.parse(timeS);
                          // serService(idser);

                          Map<String, dynamic> _map = {
                            "N_id": nid,
                            "P_id": pid,
                            "S_id": sid,
                            "B_status": status,
                            "B_timesttr": timeS,
                            "B_time_end": timeE,
                            "B_hos": hospital,
                            "B_date_ser": date,
                            "B_fee": fee,
                          };

                          var json = jsonEncode(_map);
                          bookSer(http.Client(), json);
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue.shade500),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  // Future<Null> serService(int sid) async {
  //   String url =
  //       '${MyCostant().domain}/care/app/service.php?isAdd=true&idser=$sid';
  //   try {
  //     final http.Response response = await http.Client().get(
  //       url,
  //     );
  //     print('res = $response');
  //     var result = json.decode(response.body);
  //     print('result = $result');
  //     for (var map in result) {
  //       GetService getService = GetService.fromJson(map);
  //       if (sid == 1) {
  //         charge = int.parse(getService.serCharge);
  //         sertime = int.parse(getService.serTime);
  //         fee = charge + sertime;
  //         // print(fee);
  //       }
  //     }
  //   } catch (e) {}
  // }
  Future<Null> nurse() async {
    String url =
        '${MyCostant().domain}/care/app/typecare.php?isAdd=true&nnid=$nnid';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      for (var map in result) {
        Gettypecare gettypecare = Gettypecare.fromJson(map);
        scharge = gettypecare.sCharge;
      }
    } catch (e) {}
  }

  Future<Null> bookSer(http.Client client, var json) async {
    try {
      final response = await client.post(Server().book,
          headers: {"Content-Type": "application/json"}, body: json);
      print('res1 = ${response.body}');
      var getData = jsonDecode(response.body);
      print(getData['status']);
      if (getData['status'] == 'true') {
        MyStyle().ShowProgess();
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Profile1());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
        normalDialog(context, 'จองสำเร็จ');
      } else {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Service());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
        normalDialog(context, 'ผู้ดูแลไม่ว่าง');
      }
    } catch (e) {}
  }
}
