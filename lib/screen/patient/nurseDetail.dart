import 'package:flutter/material.dart';
import 'book.dart';

class Ndetail extends StatefulWidget {
  Ndetail({Key key}) : super(key: key);

  @override
  _NdetailState createState() => _NdetailState();
}

class _NdetailState extends State<Ndetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Name Surnamae'),
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
                    Text(
                      'Name_surname',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Age:   ',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          '32',
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
                          'Weigth:   ',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          '45    ',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          'Height:   ',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          '165',
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
                          'Fee:   ',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          'Go to hospital    ',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          '120 /hr   ',
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
                          'Getmedicine:   ',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          '250/time',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    RaisedButton(
                        onPressed: () {
                          MaterialPageRoute route =
                         MaterialPageRoute(builder: (value) => Book());
                          Navigator.push(context, route);
                        },
                        child: Text(
                          'Book',
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
}
