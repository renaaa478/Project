import 'myconstant.dart';

class Server {
  String addUser = "${MyCostant().domain}/care/app/addData.php";
  String addpatient = "${MyCostant().domain}/care/app/addRePa.php";
  String addNurse = "${MyCostant().domain}/care/app/AddreNurse.php";
  String findUser = "${MyCostant().domain}/care/app/getUserWhereUser.php";
  String book = "${MyCostant().domain}/care/app/book.php";
  String editProfile = "${MyCostant().domain}/care/app/editPatient.php";
  String addAdvice = "${MyCostant().domain}/care/app/addAdvice.php";
  String addComment = "${MyCostant().domain}/care/app/addComment.php";
  Server() : super();
}
