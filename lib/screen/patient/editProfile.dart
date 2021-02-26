import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projectapp/model/getPatient.dart';
import 'package:projectapp/screen/patient/prodetail.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:projectapp/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String nameUser, surname, username, add, phones, mail, con;
  GetPatient getPatient;
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
        '${MyCostant().domain}/care/app/getPatient.php?isAdd=true&P_username=$username';
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
          getPatient = GetPatient.fromJson(map);
          nameUser = getPatient.pName;
          surname = getPatient.pSername;
          mail = getPatient.pEmail;
          phones = getPatient.pPhone;
          add = getPatient.pAdd;
          con = getPatient.pCon;
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
      body: getPatient == null ? MyStyle().ShowProgess() : showContent(),
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
            ccon(),
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
                      add.isEmpty ||
                      con == null ||
                      con.isEmpty) {
                    normalDialog(context, 'กรุณากรอกข้อมูลให้ครบทุกช่อง');
                  } else {
                    print(
                        'name = $nameUser , sur = $surname , phone =$phones , mail = $mail ,add = $add username =$username');
                    // Map<String, dynamic> _map = {
                    //   "nameUser": nameUser,
                    //   "surname": surname,
                    //   "phones": phones,
                    //   "add": add,
                    //   "mail": mail,
                    //   "con": con,
                    //   "username": username
                    // };
                    // var json = jsonEncode(_map);
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
        '${MyCostant().domain}/care/app/editPatient.php?username=$username&surname=$surname&nameUser=$nameUser&phones=$phones&add=$add&con=$con&mail=$mail';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      if (result = true) {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => ProDetail());
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

  Widget ccon() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 300.0,
            child: TextFormField(
              onChanged: (value) => con = value,
              initialValue: con,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'โรคประจำตัว'),
            ),
          ),
        ],
      );
}
