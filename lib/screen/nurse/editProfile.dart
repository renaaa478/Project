import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projectapp/model/getNurse.dart';
import 'package:projectapp/screen/nurse/prodetailn.dart';
import 'package:projectapp/screen/patient/profile1.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:projectapp/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfilen extends StatefulWidget {
  EditProfilen({Key key}) : super(key: key);

  @override
  _EditProfilenState createState() => _EditProfilenState();
}

class _EditProfilenState extends State<EditProfilen> {
  String nameUser, surname, username, add, phones, mail, w, h;
  GetNurse getNurse;
  @override
  void initState() {
    super.initState();
    readInfo();
  }

  Future<Null> readInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('name');
      surname = preferences.getString('sername');
      username = preferences.getString('user');
      print('username == $username');
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
        print('map = $map');
        setState(() {
          getNurse = GetNurse.fromJson(map);
          nameUser = getNurse.nName;
          surname = getNurse.nSername;
          mail = getNurse.nEmail;
          phones = getNurse.nPhone;
          add = getNurse.nAdd;
          w = getNurse.nWeight;
          h = getNurse.nHeight;
        });
        // GetPatient getPatient = GetPatient.fromJson(map);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: getNurse == null ? MyStyle().ShowProgess() : showContent(),
      
    );
  }

  Widget showContent() => Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            name(),
            surnames(),
            email(),
            phone(),
            address(),
            weight(),
            height(),
            MyStyle().mySizeBox(),
            editbutton()
          ],
        ),
      ));

  Widget editbutton() => Container(
          child: RaisedButton.icon(
        color: MyStyle().primaryColor,
        onPressed: () {
          confirmDialog();
        },
        icon: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        label: Text(
          'บันทึกข้อมูล',
          style: TextStyle(color: Colors.white),
        ),
      ));
  Future<Null> confirmDialog() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการจะแก้ไขข้อมูลใช่หรือไม่?'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (nameUser == null ||
                      nameUser.isEmpty ||
                      surname == null ||
                      surname.isEmpty ||
                      mail == null ||
                      mail.isEmpty ||
                      phones == null ||
                      phones.isEmpty ||
                      add == null ||
                      add.isEmpty) {
                    normalDialog(context, 'กรุณากรอกข้อมูลให้ครบทุกช่อง');
                  } else {
                    print(
                        'name = $nameUser , sur = $surname , phone =$phones , mail = $mail ,add = $add username =$username');
                    editThead();
                  }
                },
                child: Text('บันทึก'),
              ),
              OutlineButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ยกเลิก'),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<Null> editThead() async {
    String url =
        '${MyCostant().domain}/care/app/editNurse.php?username=$username&surname=$surname&nameUser=$nameUser&phones=$phones&add=$add&mail=$mail&h=$h&w=$w';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      if (result = true) {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Profile1());
        Navigator.push(context, route).then((value) => readInfo());
      }
    } catch (e) {}
  }

  Widget name() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 300.0,
            child: TextFormField(
              onChanged: (value) => nameUser = value,
              initialValue: nameUser,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'ชื่อ'),
            ),
          ),
        ],
      );

  Widget surnames() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 300.0,
            child: TextFormField(
              onChanged: (value) => surname = value,
              initialValue: surname,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'นามสกุล'),
            ),
          ),
        ],
      );

  Widget phone() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 300.0,
            child: TextFormField(
              onChanged: (value) => phones = value,
              initialValue: phones,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'เบอร์โทร'),
            ),
          ),
        ],
      );
  Widget email() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 300.0,
            child: TextFormField(
              onChanged: (value) => mail = value,
              initialValue: mail,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'อีเมล์'),
            ),
          ),
        ],
      );

  Widget address() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 300.0,
            child: TextFormField(
              onChanged: (value) => add = value,
              initialValue: add,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'ที่อยู่'),
            ),
          ),
        ],
      );
  Widget height() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 300.0,
            child: TextFormField(
              onChanged: (value) => h = value,
              initialValue: h,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'ส่วนสูง'),
            ),
          ),
        ],
      );
  Widget weight() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 300.0,
            child: TextFormField(
              onChanged: (value) => w = value,
              initialValue: w,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'น้ำหนัก'),
            ),
          ),
        ],
      );
}
