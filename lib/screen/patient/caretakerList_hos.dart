import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectapp/model/allnurse.dart';
import 'package:projectapp/screen/patient/book.dart';
import 'package:projectapp/screen/patient/proNurse.dart';
import 'package:projectapp/utility/myconstant.dart';
import 'package:projectapp/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NurseListhos extends StatefulWidget {
  final String ser1;
  NurseListhos({Key key, @required this.ser1}) : super(key: key);

  @override
  _NurseListhosState createState() => _NurseListhosState();
}

class _NurseListhosState extends State<NurseListhos> {
  String service, hos, nameUser, surname, username, nid, idser;
  List<GetAllNurse> getallNurses = List();
  @override
  void initState() {
    super.initState();
    findUser();
    readNurse();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('name');
      surname = preferences.getString('sername');
      username = preferences.getString('user');
      nid = preferences.getString('nid');
    });
  }

  Future<Null> readNurse() async {
    String url = '${MyCostant().domain}/care/app/getAllNurse.php?isAdd=true';
    try {
      final http.Response response = await http.Client().get(
        url,
      );
      print('res = $response');
      var result = json.decode(response.body);
      print('result = $result');
      if (result.toString() != null) {
        for (var map in result) {
          GetAllNurse getAllNurse = GetAllNurse.fromJson(map);

          setState(() {
            getallNurses.add(getAllNurse);
            // print(' map = $map');
          });
        }
      } else {
        Text('ไม่มีข้อมูล');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    service = "${widget.ser1}";
    idser = '2';
    return Scaffold(
        appBar: AppBar(
          title: Text('Caretaker'),
        ),
        body: Container(decoration: BoxDecoration(
              gradient: RadialGradient(
            colors: <Color>[Colors.white, MyStyle().primaryColor],
            center: Alignment(0, -0.3),
            radius: 2.5,
          )),
          child: ListView.builder(
            itemCount: getallNurses.length,
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
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      Container(
                        width: 55.0,
                        height: 55.0,
                        color: Colors.blue[200],
                        child: CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          foregroundColor: Colors.blue[100],
                          backgroundImage: NetworkImage(
                              "https://www.nursingworld.org/~4adc9e/globalassets/social-networking-principles-toolkit/largeimage-anais-20.jpg"),
                        ),
                      ),
                      SizedBox(width: 6.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(getallNurses[index].nName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                              Text((' '),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                              Text(getallNurses[index].nSername,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(getallNurses[index].nnName,
                              style: TextStyle(color: Colors.grey)),
                          Row(
                            children: [
                              Text(getallNurses[index].sCharge,
                                  style: TextStyle(color: Colors.grey)),
                              Text('/hr', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: FlatButton(
                              onPressed: () {
                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (value) => Book(
                                    service: service,
                                    getNurse: getallNurses[index],
                                    idser:idser,
                                  ),
                                );
                                Navigator.push(context, route)
                                    .then((value) => null);
                              },
                              color: Colors.red[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text("Book",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.0, vertical: 3.0),
                            child: FlatButton(
                              onPressed: () {
                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (value) => ProNurse(getNurse: getallNurses[index],
                                    
                                  ),
                                );
                                Navigator.push(context, route)
                                    .then((value) => readNurse());
                              },
                              color: Colors.red[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text("Profile",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  //  widget(child: Container(alignment: Alignment.center,))
                ),
              ),
            ),
          ),
        ));
  }
}
