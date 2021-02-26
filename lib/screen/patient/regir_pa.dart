import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectapp/screen/login.dart';
import 'package:projectapp/utility/normal_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:projectapp/utility/server.dart';

class Repa extends StatefulWidget {
  final String user, name, surname;
  Repa({
    Key key,
    @required this.user,
    this.name,
    this.surname,
  }) : super(key: key);
  @override
  _RepaState createState() => _RepaState();
}

class _RepaState extends State<Repa> {
  String names, surname, address, brith, sex, age, con, username, email, phone;
  File file;

  @override
  Widget build(BuildContext context) {
    username = "${widget.user}";
    names = "${widget.name}";
    surname = "${widget.surname}";
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Register'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Form(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.add_a_photo,
                          size: 30.0,
                        ),
                        onPressed: () => chooseImage(ImageSource.camera)),
                    Container(
                      width: 150.0,
                      child: file == null
                          ? Image.asset('images/imgg.png')
                          : Image.file(file),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.add_photo_alternate,
                          size: 30.0,
                        ),
                        onPressed: () => chooseImage(ImageSource.gallery)),
                  ],
                ),

                // SizedBox(
                //   // width: MediaQuery.of(context).size.width * 0.45,
                //   child: TextFormField(
                //     decoration: InputDecoration(labelText: "ID Card"),
                //   ),
                // ),

                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.45,
                  child: TextFormField(
                    onChanged: (value) => brith = value.trim(),
                    decoration: InputDecoration(labelText: "Birth Day"),
                  ),
                ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.45,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) => age = value.trim(),
                    decoration: InputDecoration(labelText: "Age"),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text('Gender'),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: ListTile(
                        title: Text('Male'),
                        leading: Radio(
                          value: 'male',
                          groupValue: sex,
                          onChanged: (value) {
                            sex = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: ListTile(
                          title: Text('Female'),
                          leading: Radio(
                            value: 'female',
                            groupValue: sex,
                            onChanged: (value) {
                              sex = value;
                              setState(() {});
                            },
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.45,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) => phone = value.trim(),
                    decoration: InputDecoration(labelText: "Phone"),
                  ),
                ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.45,
                  child: TextFormField(
                    onChanged: (value) => email = value.trim(),
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.45,
                  child: TextFormField(
                    onChanged: (value) => address = value.trim(),
                    decoration: InputDecoration(labelText: "Address"),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                showMap(),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.45,
                  child: TextFormField(
                    onChanged: (value) => con = value.trim(),
                    decoration:
                        InputDecoration(labelText: "congenital disease"),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      onPressed: () async {
                        print(
                            ' address = $address , birth =$brith , sex =$sex , age =$age , email =$email ,phone =$phone, con =$con');
                        if (address == null ||
                            address.isEmpty ||
                            sex == null ||
                            sex.isEmpty ||
                            email == null ||
                            email.isEmpty ||
                            phone == null ||
                            phone.isEmpty ||
                            age == null ||
                            age.isEmpty ||
                            con == null ||
                            con.isEmpty) {
                          normalDialog(context, 'กรูณากรอกข้อมูลให้ครบทุกช่อง');
                        } else {
                          Map<String, dynamic> _map = {
                            "name": names,
                            "surname": surname,
                            "age": age,
                            "address": address,
                            "birth": brith,
                            "phone": phone,
                            "email": email,
                            "username": username,
                            "con": con,
                            "sex": sex
                          };
                          var json = jsonEncode(_map);
                          addRepa(http.Client(), json);
                          routeTuService(Login());
                        }
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue.shade500),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  Container showMap() {
    LatLng latLng = LatLng(7.046167, 100.473929);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );
    return Container(
      height: 250.0,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
      ),
    );
  }

 Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker().getImage(
        source: source,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );
      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Future<Null> routeTuService(Widget myWidget) async {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  //-----------server-------------
  Future<Null> addRepa(http.Client client, var json) async {
    // String url = 'http://192.168.1.42/care/app/addRePa.php';
    try {
      final response = await client.post(Server().addpatient,
          headers: {"Content-Type": "application/json"}, body: json);
      print('res1 = ${response.body}');
      var getData = jsonDecode(response.body);
      print(getData['status']);
    } catch (e) {}
  }

  // Future<Null> chooseImage(ImageSource imageSource) async {
  //   try {
  //     var object = await ImagePicker.pickImage(
  //         source: imageSource, maxHeight: 800.0, maxWidth: 800.0);
  //     setState(() {
  //       file = object;
  //     });
  //   } catch (e) {}
  // }
}
