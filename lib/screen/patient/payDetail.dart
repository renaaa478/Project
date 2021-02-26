import 'package:flutter/material.dart';
import 'package:projectapp/model/getbook.dart';
import 'package:projectapp/screen/patient/profile1.dart';
import 'package:projectapp/utility/mystyle.dart';

class PayDetail extends StatefulWidget {
  final GetBook getBook;

  PayDetail({Key key, this.getBook}) : super(key: key);

  @override
  _PayDetailState createState() => _PayDetailState();
}

class _PayDetailState extends State<PayDetail> {
  GetBook getBook;
  String price;

  // File _imageFile;
  // String _status;
  // bool _imageLoading;
  // ImagePicker _imagePicker;
  @override
  void initState() {
    super.initState();
    getBook = widget.getBook;
    // _status = '';
    // _imageLoading = false;
    // _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    price = "${getBook.bFee}";
    print(price);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[20],
        title: Text('Payment'),
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
            colors: <Color>[Colors.white, MyStyle().primaryColor],
            center: Alignment(0, -0.3),
            radius: 3.5,
          )),
          child: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 20.0, top: 20.0)),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 20.0, top: 10.0)),
                      Text(
                        'Bank Account',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'ธนาคารกรุงไทย',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'เลขบัญชี : 702-2-01547-8',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'ชื่อบัญชี : ชนัศชัย วงวิบูลย์',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'ยอดที่ต้องชำระ $price บาท',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      Text('  ')
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30.0)),
              Container(
                width: 80,
                height: 200,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 0),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        fit: BoxFit.scaleDown,
                        image: AssetImage('images/imgg.png'))),
              ),
              Container(
                padding: EdgeInsets.only(left: 100.0, right: 100.0),
                width: 50.0,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text("UPLOAD IMAEG"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 100.0, right: 100.0, top: 15.0),
                width: 50.0,
                child: RaisedButton(
                  color: Colors.blue[400],
                  onPressed: () {
                     MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Profile1());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
                  },
                  child: Text(
                    "SAVE INFORMATION",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              )

              // child: ListTile(
              //     leading: Icon(
              //       Icons.account_balance,
              //       color: Colors.blue,
              //     ),
              //     title: Column(
              //       children: [Padding(padding: EdgeInsets.only(left: 20.0)),
              //         Text(
              //           'Bank Account',
              //           style: TextStyle(
              //             fontSize: 18.0,
              //             color: Colors.blue,
              //             fontWeight: FontWeight.bold
              //           ),
              //         ),
              //         Text(
              //           'ธนาคารกรุงไทย',
              //           style: TextStyle(
              //             fontSize: 18.0,
              //             color: Colors.blue,
              //             fontWeight: FontWeight.bold
              //           ),
              //         ),

              //       ],
              //     ),

              //     ),
            ],
          )
          // Container(
          //     decoration: BoxDecoration(
          //         gradient: RadialGradient(
          //   colors: <Color>[Colors.white, MyStyle().primaryColor],
          //   center: Alignment(0, -0.2),
          //   radius: 3.5,
          // ))),
          // Padding(padding: EdgeInsets.only(top: 50.0)),

          ),
    );
  }
}
