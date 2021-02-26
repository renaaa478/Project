class GetPatient {
  String pId;
  String pName;
  String pSername;
  String pEmail;
  String pPhone;
  String image;
  String pLatitude;
  String pLongtitude;
  String pAdd;
  String sex;
  String pAge;
  String pBirth;
  String pCon;
  String pUsername;
  String id;
  String chooseType;
  String name;
  String surname;
  String user;
  String password;

  GetPatient(
      {this.pId,
      this.pName,
      this.pSername,
      this.pEmail,
      this.pPhone,
      this.image,
      this.pLatitude,
      this.pLongtitude,
      this.pAdd,
      this.sex,
      this.pAge,
      this.pBirth,
      this.pCon,
      this.pUsername,
      this.id,
      this.chooseType,
      this.name,
      this.surname,
      this.user,
      this.password});

  GetPatient.fromJson(Map<String, dynamic> json) {
    pId = json['P_id'];
    pName = json['P_name'];
    pSername = json['P_sername'];
    pEmail = json['P_email'];
    pPhone = json['P_phone'];
    image = json['image'];
    pLatitude = json['P_latitude'];
    pLongtitude = json['P_longtitude'];
    pAdd = json['P_add'];
    sex = json['sex'];
    pAge = json['P_age'];
    pBirth = json['P_birth'];
    pCon = json['P_con'];
    pUsername = json['P_username'];
    id = json['id'];
    chooseType = json['chooseType'];
    name = json['name'];
    surname = json['surname'];
    user = json['user'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['P_id'] = this.pId;
    data['P_name'] = this.pName;
    data['P_sername'] = this.pSername;
    data['P_email'] = this.pEmail;
    data['P_phone'] = this.pPhone;
    data['image'] = this.image;
    data['P_latitude'] = this.pLatitude;
    data['P_longtitude'] = this.pLongtitude;
    data['P_add'] = this.pAdd;
    data['sex'] = this.sex;
    data['P_age'] = this.pAge;
    data['P_birth'] = this.pBirth;
    data['P_con'] = this.pCon;
    data['P_username'] = this.pUsername;
    data['id'] = this.id;
    data['chooseType'] = this.chooseType;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['user'] = this.user;
    data['password'] = this.password;
    return data;
  }
}
