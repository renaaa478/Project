import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projectapp/model/allnurse.dart';
import 'package:projectapp/model/getNurse.dart';
import 'package:projectapp/model/getPatient.dart';
import 'package:projectapp/model/getservice.dart';
import 'package:projectapp/model/typecare.dart';
import 'package:projectapp/model/typrser.dart';
import 'package:projectapp/screen/patient/bookDetail.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:projectapp/utility/normal_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Book extends StatefulWidget {
  final String service, idser;
  final GetAllNurse getNurse;
  Book({Key key, this.service, this.getNurse, this.idser}) : super(key: key);
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  GetAllNurse getallNurse;
  int sserid;
  String name,
      surname,
      ser,
      nid,
      idser,
      date,
      hos,
      pid,
      fee1,
      nnid,
      nameUser,
      username;
  var _timeVal;
  var _timeVal2, tt, charge;
  double t1, t2, fee, sertime, scharge;
  @override
  void initState() {
    super.initState();
    getallNurse = widget.getNurse;
    idser = widget.idser;
    nid = getallNurse.nId;
    nnid = getallNurse.nnId;
    findUser();
    print(nnid);
  }

  List _time = [
    '08.00',
    '09.00',
    '10.00',
    '11.00',
    '12.00',
    '13.00',
    '14.00',
    '15.00',
    '16.00',
    '17.00'
  ];
  List _time2 = [
    '08.00',
    '09.00',
    '10.00',
    '11.00',
    '12.00',
    '13.00',
    '14.00',
    '15.00',
    '16.00',
    '17.00'
  ];
  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      // pid = preferences.getString('pid');
      nameUser = preferences.getString('name');
      surname = preferences.getString('sername');
      username = preferences.getString('user');
    });
    String url =
        '${MyCostant().domain}/care/app/getpatient.php?isAdd=true&P_username=$username';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      for (var map in result) {
        GetPatient getPatient = GetPatient.fromJson(map);
        pid = getPatient.pId;
        service();
      }
    } catch (e) {}
  }

  Future<Null> service() async {
    String url =
        '${MyCostant().domain}/care/app/getservice.php?isAdd=true&idser=$idser';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      for (var map in result) {
        GetServices getServices = GetServices.fromJson(map);
        charge = double.parse(getServices.charge);
      }
    } catch (e) {}
  }

  Future<Null> readNurse() async {
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
        scharge = double.parse(gettypecare.sCharge);
      }
      fee = charge + scharge * tt;
      fee1 = fee.toString();
      MaterialPageRoute route = MaterialPageRoute(
          builder: (value) => Bdetail(
              nid: nid,
              pid: pid,
              sid: idser,
              status: '1',
              timeS: _timeVal,
              timeE: _timeVal2,
              hospital: hos,
              date: date,
              name: name,
              surname: surname,
              fee: fee1,
              nnid: nnid,
              ser: ser));
      Navigator.push(context, route);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    ser = "${widget.service}";
    name = "${getallNurse.nName}";
    surname = "${getallNurse.nSername}";
    nid = "${getallNurse.nId}";
    idser = "${widget.idser}";
    nnid = "${getallNurse.nnId}";
    return Scaffold(
      appBar: AppBar(
        title: Text('Book'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: <Color>[Colors.white, MyStyle().primaryColor],
          center: Alignment(0, -0.3),
          radius: 3.5,
        )),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Form(
                child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 30.0)),
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 3),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/nurse.jpg'))),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Row(
                  children: [
                    Text(
                      'Caretaker :',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      ' ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      surname,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 25.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Service:   ',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ser,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Container(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.blue[100], width: 2.0),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: DropdownButton(
                          hint: Text(
                            'time start',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                          ),
                          dropdownColor: Colors.blue[50],
                          elevation: 5,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blue,
                          ),
                          iconSize: 36.0,
                          isExpanded: true,
                          value: _timeVal,
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                          onChanged: (value) {
                            setState(() {
                              _timeVal = value;
                            });
                          },
                          items: _time.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Container(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.blue[100], width: 2.0),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: DropdownButton(
                          hint: Text(
                            'time end',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                          ),
                          dropdownColor: Colors.blue[50],
                          elevation: 5,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blue,
                          ),
                          iconSize: 36.0,
                          isExpanded: true,
                          value: _timeVal2,
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                          onChanged: (value) {
                            setState(() {
                              _timeVal2 = value;
                              // t2 = int.parse(_timeVal2);
                            });
                          },
                          items: _time2.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.45,
                  child: TextFormField(
                    onChanged: (value) => date = value.trim(),
                    decoration: InputDecoration(
                        hintText: '2020-03-30',
                        suffixIcon: Icon(
                          Icons.date_range,
                          color: Colors.blue,
                        ),
                        labelText: "Date"),
                  ),
                ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.45,
                  child: TextFormField(
                    onChanged: (value) => hos = value.trim(),
                    decoration: InputDecoration(labelText: "Hospital"),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 25.0)),
                RaisedButton(
                    onPressed: () {
                      print(
                          'idn = $nid , idp =$pid ,idser =$idser,service=$ser,timeS=$_timeVal,timeE=$_timeVal2 date = $date');
                      if (name == null ||
                          name.isEmpty ||
                          surname == null ||
                          surname.isEmpty ||
                          _timeVal == null ||
                          _timeVal2 == null ||
                          hos == null ||
                          hos.isEmpty ||
                          date == null ||
                          date.isEmpty ||
                          ser == null ||
                          ser.isEmpty ||
                          idser == null ||
                          idser.isEmpty) {
                        normalDialog(context, 'กรุณากรอกข้อมูลให้ครบทุกช่อง');
                      } else {
                        t1 = double.parse(_timeVal);
                        t2 = double.parse(_timeVal2);
                        tt = t2 - t1;

                        readNurse();

                        // normalDialog(context, 'จองสำเร็จ');
                      }
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue.shade500),
              ],
            )),
          ),
        ),
      ),
    );
  }

  // Future<Null> setService(int tt) async {
  //   String url =
  //       '${MyCostant().domain}/care/app/typecare.php?isAdd=true&nnid=$nnid';
  //   try {
  //     final http.Response response = await http.Client().get(
  //       url,
  //     );
  //     print('res = $response');
  //     var result = json.decode(response.body);
  //     print('result = $result');
  //     for (var map in result) {
  //       GetService getService = GetService.fromJson(map);
  //       charge = double.parse(getService.serCharge);
  //       sertime = double.parse(getService.serTime);
  //       fee = charge + sertime * tt;
  //       fee1 = fee.toString();
  //     }
  //   } catch (e) {}

}
