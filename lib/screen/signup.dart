import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projectapp/screen/patient/regir_pa.dart';
import 'package:projectapp/screen/nurse/regis_nurse.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:projectapp/utility/normal_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:projectapp/utility/server.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String chooceType, name, user, surname, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          myLogo(),
          shoeAppNmae(),
          MyStyle().mySizeBox(),
          nameForm(),
          MyStyle().mySizeBox(),
          surnameForm(),
          MyStyle().mySizeBox(),
          userForm(),
          MyStyle().mySizeBox(),
          passwordForm(),
          userRadio(),
          patientRadio(),
          regisButton(),
        ],
      ),
    );
  }

  Widget regisButton() {
    return Container(
      width: 200.0,
      child: RaisedButton(
        color: MyStyle().darkColor,
        onPressed: () {
          print(
              'name = $name , user =$user , password =$password , chooseType = $chooceType');
          if (name == null ||
              name.isEmpty ||
              user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty ||
              chooceType == null ||
              chooceType.isEmpty) {
            print('Have space');
            normalDialog(context, 'กรุณากรอกข้อมูลให้ครบทุกช่อง');
          } else if (chooceType == null) {
            normalDialog(context, 'โปรดเลือกประเภทของผู้สมัคร');
          } else {
            checkUser();
          }
        },
        child: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> checkUser() async {
    String url =
        '${MyCostant().domain}/care/app/getUserWhereUser.php?isAdd=true&user=$user';

    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');

      if (result.toString() == 'null') {
        Map<String, dynamic> _map = {
          "name": name,
          "surname": surname,
          "password": password,
          "user": user,
          "chooceType": chooceType
        };
        var json = jsonEncode(_map);
        registerThread(http.Client(), json);
      } else {
        normalDialog(context, 'User $user มีผู้ใช้งานแล้ว');
      }
    } catch (e) {}
  }

  Future<Null> registerThread(http.Client client, var json) async {
    // String url = 'http://192.168.1.42/care/app/addData.php';
    try {
      // Response<Map> response = await Dio().post(url,data: json);

      final response = await client.post(Server().addUser,
          headers: {"Content-Type": "application/json"}, body: json);
      print('res1 = ${response.body}');
      var getData = jsonDecode(response.body);
      print(getData['status']);

      if (getData['status'] == 'true' && chooceType == 'user') {
        //Don't have back navigator
        MaterialPageRoute route = MaterialPageRoute(
            // ----------------------- การส่งค่า user ไปอีกหน้า------------------
            builder: (value) => Renurse(
                  user: user,
                  name: name,
                  surname: surname,
                ));
        Navigator.push(context, route);
      } else if (getData['status'] == 'true' && chooceType == 'patient') {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (value) => Repa(
                  user: user,
                  name: name,
                  surname: surname,
                ));
        Navigator.push(context, route);
      } else {
        normalDialog(context, 'ไม่สามารถลงทะเบียนได้');
      }
    } catch (e) {}
  }

  Row userRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Radio(
            value: 'user',
            groupValue: chooceType,
            onChanged: (value) {
              chooceType = value;
              setState(() {});
            },
          ),
          Text(
            'ผู้ดูแล',
            style: TextStyle(color: MyStyle().primaryColor),
          ),
        ],
      );

  Row patientRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Radio(
            value: 'patient',
            groupValue: chooceType,
            onChanged: (value) {
              chooceType = value;
              setState(() {});
            },
          ),
          Text(
            'ผู้ป่วย',
            style: TextStyle(color: MyStyle().primaryColor),
          ),
        ],
      );

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => name = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.face,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'name :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );
  Widget surnameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => surname = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.face,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'surname :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget userForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => user = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_box,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'User name :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => password = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'password :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Row shoeAppNmae() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyStyle().showText('V-care'),
      ],
    );
  }

  Widget myLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyStyle().showLogo(),
        ],
      );
}
