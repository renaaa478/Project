class Getcomment {
  String cId;
  String cDate;
  String cCom;
  String pId;
  String nId;
  String bId;
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
  String nName;
  String nSername;
  String nEmail;
  String nPhone;
  String nAdd;
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
  String bDate;
  String sId;
  String bStatus;
  String bTimesttr;
  String bTimeEnd;
  String bHos;
  String bFee;
  String bDateSer;
  String bPay;
  String statusAdv;

  Getcomment(
      {this.cId,
      this.cDate,
      this.cCom,
      this.pId,
      this.nId,
      this.bId,
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
      this.nName,
      this.nSername,
      this.nEmail,
      this.nPhone,
      this.nAdd,
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
      this.bDate,
      this.sId,
      this.bStatus,
      this.bTimesttr,
      this.bTimeEnd,
      this.bHos,
      this.bFee,
      this.bDateSer,
      this.bPay,
      this.statusAdv});

  Getcomment.fromJson(Map<String, dynamic> json) {
    cId = json['C_id'];
    cDate = json['C_date'];
    cCom = json['C_com'];
    pId = json['P_id'];
    nId = json['N_id'];
    bId = json['B_id'];
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
    nName = json['N_name'];
    nSername = json['N_sername'];
    nEmail = json['N_email'];
    nPhone = json['N_phone'];
    nAdd = json['N_add'];
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
    bDate = json['B_date'];
    sId = json['S_id'];
    bStatus = json['B_status'];
    bTimesttr = json['B_timesttr'];
    bTimeEnd = json['B_time_end'];
    bHos = json['B_hos'];
    bFee = json['B_fee'];
    bDateSer = json['B_date_ser'];
    bPay = json['B_pay'];
    statusAdv = json['status_adv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['C_id'] = this.cId;
    data['C_date'] = this.cDate;
    data['C_com'] = this.cCom;
    data['P_id'] = this.pId;
    data['N_id'] = this.nId;
    data['B_id'] = this.bId;
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
    data['N_name'] = this.nName;
    data['N_sername'] = this.nSername;
    data['N_email'] = this.nEmail;
    data['N_phone'] = this.nPhone;
    data['N_add'] = this.nAdd;
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
    data['B_date'] = this.bDate;
    data['S_id'] = this.sId;
    data['B_status'] = this.bStatus;
    data['B_timesttr'] = this.bTimesttr;
    data['B_time_end'] = this.bTimeEnd;
    data['B_hos'] = this.bHos;
    data['B_fee'] = this.bFee;
    data['B_date_ser'] = this.bDateSer;
    data['B_pay'] = this.bPay;
    data['status_adv'] = this.statusAdv;
    return data;
  }
}
