import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projectapp/screen/login.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/normal_dialog.dart';
import 'package:projectapp/utility/server.dart';

class Renurse extends StatefulWidget {
  // -------------การรับค่า user จากหน้า signup-------------
  final String user, name, surname;
  Renurse({
    Key key,
    @required this.user,
    this.name,
    this.surname,
  }) : super(key: key);
  @override
  _RenurseState createState() => _RenurseState();
}

class _RenurseState extends State<Renurse> {
  String name,
      surname,
      weight,
      height,
      brith,
      sex,
      age,
      phone,
      cer,
      email,
      address,
      type,
      user;
  double lat, lng;

  // @override
  // void initState() {
  //   super.initState();
  //   findLatLng();
  // }

  // Future<Null> findLatLng() async {
  //   LocationData locationData = await findLocationData();
  //   lat = locationData.latitude;
  //   lng = locationData.longitude;
  //   print('lat = $lat , lng = $lng');
  // }

  // Future<LocationData> findLocationData() async {
  //   Location location = Location();
  //   try {
  //     return location.getLocation();
  //   } catch (e) {
  //     return null;
  //   }
  // }
  String selectedValue;
  List typecarelist = List();
  Future<Null> getType() async {
    String url = '${MyCostant().domain}/care/app/getAllcaretype.php?isAdd=true';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      setState(() {
        typecarelist = result;
      });
      print(typecarelist);
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    getType();
  }

  @override
  Widget build(BuildContext context) {
    user = "${widget.user}";
    name = "${widget.name}";
    surname = "${widget.surname}";
    return Scaffold(
      appBar: AppBar(
        title: Text('Caretaker Register'),
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
                        onPressed: () {}),
                    Container(
                      width: 150.0,
                      child: Image.asset('images/imgg.png'),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.add_photo_alternate,
                          size: 30.0,
                        ),
                        onPressed: () {}),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => weight = value.trim(),
                        decoration: InputDecoration(
                          labelText: "weight",
                          // enabledBorder: OutlineInputBorder(
                          //     borderSide:
                          //         BorderSide(color: MyStyle().darkColor)),
                          // focusedBorder: OutlineInputBorder(
                          //     borderSide:
                          //         BorderSide(color: MyStyle().primaryColor)),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => height = value.trim(),
                        decoration: InputDecoration(
                          labelText: "Height",
                          // enabledBorder: OutlineInputBorder(
                          //     borderSide:
                          //         BorderSide(color: MyStyle().darkColor)),
                          // focusedBorder: OutlineInputBorder(
                          //     borderSide:
                          //         BorderSide(color: MyStyle().primaryColor)),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => brith = value.trim(),
                        decoration: InputDecoration(
                          hintText: '1999-04-13',
                          labelText: "Birthday",
                          // enabledBorder: OutlineInputBorder(
                          //     borderSide:
                          //         BorderSide(color: MyStyle().darkColor)),
                          // focusedBorder: OutlineInputBorder(
                          //     borderSide:
                          //         BorderSide(color: MyStyle().primaryColor)),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => age = value.trim(),
                        decoration: InputDecoration(
                          labelText: "Age",
                          // enabledBorder: OutlineInputBorder(
                          //     borderSide:
                          //         BorderSide(color: MyStyle().darkColor)),
                          // focusedBorder: OutlineInputBorder(
                          //     borderSide:
                          //         BorderSide(color: MyStyle().primaryColor)),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(8)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Gender',
                    style: TextStyle(fontSize: 16.0),
                  ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => phone = value.trim(),
                        decoration: InputDecoration(
                          labelText: "Phone",
                          // enabledBorder: OutlineInputBorder(
                          //     borderSide:
                          //         BorderSide(color: MyStyle().darkColor)),
                          // focusedBorder: OutlineInputBorder(
                          //     borderSide:
                          //         BorderSide(color: MyStyle().primaryColor)),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                        onChanged: (value) => email = value.trim(),
                        decoration: InputDecoration(
                          labelText: "Email",
                          // enabledBorder: OutlineInputBorder(
                          //     borderSide:
                          //         BorderSide(color: MyStyle().darkColor)),
                          // focusedBorder: OutlineInputBorder(
                          //     borderSide:
                          //         BorderSide(color: MyStyle().primaryColor)),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(5)),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.45,
                  child: TextFormField(
                    onChanged: (value) => type = value.trim(),
                    decoration: InputDecoration(labelText: "Certificate"),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[100], width: 2.0),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: DropdownButton(
                      hint: Text(
                        'Cartaker type',
                        style: TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                      dropdownColor: Colors.blue[50],
                      elevation: 5,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blue,
                      ),
                      iconSize: 36.0,
                      isExpanded: true,
                      value: selectedValue,
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      items: typecarelist.map((typecare) {
                        return DropdownMenuItem(
                          value: typecare['Nn_id'],
                          child: Text(typecare['Nn_name']),
                        );
                      }).toList(),
                    ),
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
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      onPressed: () {
                        print(
                            'name = $name , surname =$surname , weight =$weight, height = $height , birth =$brith , sex =$sex , age =$age , phone =$phone , email=$email , cer =$cer , addresss =$address type =$type');
                        if (name == null || name.isEmpty
                            // surname == null ||
                            // surname.isEmpty ||
                            // weight == null ||
                            // weight.isEmpty ||
                            // height == null ||
                            // height.isEmpty ||
                            // sex == null ||
                            // sex.isEmpty ||
                            // phone == null ||
                            // phone.isEmpty ||
                            // age == null ||
                            // age.isEmpty ||
                            // email == null ||
                            // email.isEmpty ||
                            // cer == null ||
                            // cer.isEmpty ||
                            // address == null ||
                            // address.isEmpty||
                            // selectedValue==null
                            ) {
                          normalDialog(context, 'กรุณากรอกข้อมูลให้ครบทุกช่อง');
                        } else {
                          Map<String, dynamic> _map = {
                            "user": user,
                            "name": name,
                            "surname": surname,
                            "age": age,
                            "weight": weight,
                            "height": height,
                            "address": address,
                            "birth": brith,
                            "phone": phone,
                            "email": email,
                            "sex": sex,
                            "type": selectedValue,
                            "cer": cer
                          };
                          var json = jsonEncode(_map);
                          addReNurse(http.Client(), json);
                          MaterialPageRoute route =
                              MaterialPageRoute(builder: (value) => Login());
                          Navigator.pushAndRemoveUntil(
                              context, route, (route) => false);
                        }
                      },
                      child: Text(
                        'Register',
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

  Future<Null> addReNurse(http.Client client, var json) async {
    // String url = 'http://192.168.1.42/care/app/AddreNurse.php';
    try {
      final response = await client.post(Server().addNurse,
          headers: {"Content-Type": "application/json"}, body: json);
      print('res1 = ${response.body}');
      var getData = jsonDecode(response.body);
      print(getData['status']);
    } catch (e) {}
  }
}
