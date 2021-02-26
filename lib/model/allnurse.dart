class GetAllNurse {
  String nId;
  String nName;
  String nSername;
  String nEmail;
  String nPhone;
  String nAdd;
  String npic;
  String nWeight;
  String nHeight;
  String nBirth;
  String nSex;
  String nAge;
  String nCer;
  String nnId;
  String nUsern;
  String nnName;
  String sCharge;

  GetAllNurse(
      {this.nId,
      this.nName,
      this.nSername,
      this.nEmail,
      this.nPhone,
      this.nAdd,
      this.npic,
      this.nWeight,
      this.nHeight,
      this.nBirth,
      this.nSex,
      this.nAge,
      this.nCer,
      this.nnId,
      this.nUsern,
      this.nnName,
      this.sCharge});

  GetAllNurse.fromJson(Map<String, dynamic> json) {
    nId = json['N_id'];
    nName = json['N_name'];
    nSername = json['N_sername'];
    nEmail = json['N_email'];
    nPhone = json['N_phone'];
    nAdd = json['N_add'];
    npic = json['npic'];
    nWeight = json['N_weight'];
    nHeight = json['N_height'];
    nBirth = json['N_birth'];
    nSex = json['N_sex'];
    nAge = json['N_age'];
    nCer = json['N_cer'];
    nnId = json['Nn_id'];
    nUsern = json['N_usern'];
    nnName = json['Nn_name'];
    sCharge = json['S_charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['N_id'] = this.nId;
    data['N_name'] = this.nName;
    data['N_sername'] = this.nSername;
    data['N_email'] = this.nEmail;
    data['N_phone'] = this.nPhone;
    data['N_add'] = this.nAdd;
    data['npic'] = this.npic;
    data['N_weight'] = this.nWeight;
    data['N_height'] = this.nHeight;
    data['N_birth'] = this.nBirth;
    data['N_sex'] = this.nSex;
    data['N_age'] = this.nAge;
    data['N_cer'] = this.nCer;
    data['Nn_id'] = this.nnId;
    data['N_usern'] = this.nUsern;
    data['Nn_name'] = this.nnName;
    data['S_charge'] = this.sCharge;
    return data;
  }
}
