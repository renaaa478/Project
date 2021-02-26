import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projectapp/model/user_model.dart';
import 'package:projectapp/screen/nurse/home.dart';
import 'package:projectapp/screen/patient/patientMain.dart';
import 'package:projectapp/screen/signup.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:projectapp/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
// Field
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: <Color>[Colors.white, MyStyle().primaryColor],
          center: Alignment(0, -0.3),
          radius: 2.5,
        )),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MyStyle().showLogo(),
              MyStyle().mySizeBox(),
              MyStyle().showText('V-Care'),
              MyStyle().mySizeBox(),
              userForm(),
              MyStyle().mySizeBox(),
              passwordForm(),
              MyStyle().mySizeBox(),
              loginButton(),
              signupButton()
            ],
          ),
        )),
      ),
    );
  }

  Widget signupButton() => Container(
        width: 250.0,
        child: RaisedButton(
          color: MyStyle().darkColor,
          onPressed: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (value) => SignUp());
            Navigator.push(context, route);
          },
          child: Text(
            'Register',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget loginButton() {
    return Container(
      width: 250.0,
      child: RaisedButton(
        color: MyStyle().darkColor,
        onPressed: () {
          if (user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            normalDialog(context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
          } else {
            chechAuthen();
          }
        },
        child: Text(
          'Sign in',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> chechAuthen() async {
    String url =
        '${MyCostant().domain}/care/app/getUserWhereUser.php?user=$user';
    try {
      // final response = await Dio().get(url);
      final http.Response response = await http.Client().get(
        url,
      );
      // print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);

        if (password == userModel.password) {
          // ลิ้งไปหน้าต่างmain
          String chooseType = userModel.chooseType;
          if (chooseType == 'user' && userModel.status == '2') {
            routeTuService(Home(), userModel);
          } else if (chooseType == 'user' && userModel.status == '1') {
            normalDialog(context, 'กรุณารอการตอบรับจากแอดมิน');
          } else if (chooseType == 'patient') {
            routeTuService(Home1(), userModel);
          } else {
            normalDialog(context, 'ลองใหม่อีกครั้ง');
          }
        } else {
          normalDialog(context, 'รหัสผ่านไม่ถูกต้อง');
        }
      }
    } catch (e) {}
  }

  Future<Null> routeTuService(Widget myWidget, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.id);
    preferences.setString('chooceType', userModel.chooseType);
    preferences.setString('name', userModel.name);
    preferences.setString('sername', userModel.surname);
    preferences.setString('user', userModel.user);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget userForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().darkColor,
            ),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'User :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          ),
        ),
      );

  Widget passwordForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: MyStyle().darkColor,
            ),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'Password :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          ),
        ),
      );
}
