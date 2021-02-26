import 'package:flutter/material.dart';
import 'package:projectapp/model/allnurse.dart';
import 'package:projectapp/screen/patient/review.dart';
import 'package:projectapp/utility/mystyle.dart';


class ProNurse extends StatefulWidget {
  final GetAllNurse getNurse;
  ProNurse({Key key, @required this.getNurse}) : super(key: key);

  @override
  _ProNurseState createState() => _ProNurseState();
}

class _ProNurseState extends State<ProNurse> {
  String nameN, surname, username, nid;
  GetAllNurse getallNurse;
  @override
  void initState() {
    super.initState();
    getallNurse = widget.getNurse;
  }

  @override
  Widget build(BuildContext context) {
    nameN = "${getallNurse.nName}";
    surname = "${getallNurse.nSername}";
    nid = "${getallNurse.nId}";
    return Scaffold(
      appBar: AppBar(
        title: Text(nameN == null ? 'PROFILE' : '$nameN $surname'),
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
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 40,
            ),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey, width: 3),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/nurse.jpg'))),
                    // alignment: Alignment.center,
                    // child: Image.asset('images/nurse.jpg')

                    // image: NetworkImage('https://www.nursingworld.org/~4adc9e/globalassets/social-networking-principles-toolkit/largeimage-anais-20.jpg')
                  ),
                  Padding(padding: EdgeInsets.only(top: 40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 20.0)),
                      Text(
                        'ชื่อ - สกุล:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        '$nameN $surname',
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
                      Padding(padding: EdgeInsets.only(left: 20.0)),
                      Text(
                        'Caretaker type:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        '${getallNurse.nnName}',
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
                      Padding(padding: EdgeInsets.only(left: 20.0)),
                      Text(
                        'Address:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        '${getallNurse.nAdd}',
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
                      Padding(padding: EdgeInsets.only(left: 20.0)),
                      Text(
                        'Sex:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        '${getallNurse.nSex}',
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
                      Padding(padding: EdgeInsets.only(left: 20.0)),
                      Text(
                        'weight :   ',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        '${getallNurse.nWeight} kg',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        '     ',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        'Height :  ',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        '${getallNurse.nHeight} cm',
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
                      Padding(padding: EdgeInsets.only(left: 20.0)),
                      Text(
                        'Age:   ',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        '${getallNurse.nAge} year old',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 25.0)),
                  RaisedButton(
                      onPressed: () {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (value) => ReviewN(nidd:nid));
                        Navigator.push(context, route);
                      },
                      child: Text(
                        'review',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue.shade500),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  

  void rountInfo(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.push(context, route);
  }
}
