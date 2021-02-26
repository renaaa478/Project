class GetNurse {
  String id;
  String chooseType;
  String name;
  String surname;
  String user;
  String password;
  String nId;
  String nName;
  String nSername;
  String nEmail;
  String nPhone;
  String nAdd;
  String image;
  String nLatitude;
  String nLongtitude;
  String nWeight;
  String nHeight;
  String nBirth;
  String nSex;
  String nAge;
  String nCer;
  String nnId;
  String nUsern;
  String nnName;

  GetNurse(
      {this.id,
      this.chooseType,
      this.name,
      this.surname,
      this.user,
      this.password,
      this.nId,
      this.nName,
      this.nSername,
      this.nEmail,
      this.nPhone,
      this.nAdd,
      this.image,
      this.nLatitude,
      this.nLongtitude,
      this.nWeight,
      this.nHeight,
      this.nBirth,
      this.nSex,
      this.nAge,
      this.nCer,
      this.nnId,
      this.nUsern,
      this.nnName});

  GetNurse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chooseType = json['chooseType'];
    name = json['name'];
    surname = json['surname'];
    user = json['user'];
    password = json['password'];
    nId = json['N_id'];
    nName = json['N_name'];
    nSername = json['N_sername'];
    nEmail = json['N_email'];
    nPhone = json['N_phone'];
    nAdd = json['N_add'];
    image = json['image'];
    nLatitude = json['N_latitude'];
    nLongtitude = json['N_longtitude'];
    nWeight = json['N_weight'];
    nHeight = json['N_height'];
    nBirth = json['N_birth'];
    nSex = json['N_sex'];
    nAge = json['N_age'];
    nCer = json['N_cer'];
    nnId = json['Nn_id'];
    nUsern = json['N_usern'];
    nnName = json['Nn_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chooseType'] = this.chooseType;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['user'] = this.user;
    data['password'] = this.password;
    data['N_id'] = this.nId;
    data['N_name'] = this.nName;
    data['N_sername'] = this.nSername;
    data['N_email'] = this.nEmail;
    data['N_phone'] = this.nPhone;
    data['N_add'] = this.nAdd;
    data['image'] = this.image;
    data['N_latitude'] = this.nLatitude;
    data['N_longtitude'] = this.nLongtitude;
    data['N_weight'] = this.nWeight;
    data['N_height'] = this.nHeight;
    data['N_birth'] = this.nBirth;
    data['N_sex'] = this.nSex;
    data['N_age'] = this.nAge;
    data['N_cer'] = this.nCer;
    data['Nn_id'] = this.nnId;
    data['N_usern'] = this.nUsern;
    data['Nn_name'] = this.nnName;
    return data;
  }
}
