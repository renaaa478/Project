class GetAdvice {
  String advId;
  String bId;
  String pId;
  String nId;
  String advice;
  String bDate;
  String sId;
  String bStatus;
  String bTimesttr;
  String bTimeEnd;
  String bHos;
  String bFee;
  String bDateSer;
  String bPay;

  GetAdvice(
      {this.advId,
      this.bId,
      this.pId,
      this.nId,
      this.advice,
      this.bDate,
      this.sId,
      this.bStatus,
      this.bTimesttr,
      this.bTimeEnd,
      this.bHos,
      this.bFee,
      this.bDateSer,
      this.bPay});

  GetAdvice.fromJson(Map<String, dynamic> json) {
    advId = json['adv_id'];
    bId = json['B_id'];
    pId = json['P_id'];
    nId = json['N_id'];
    advice = json['advice'];
    bDate = json['B_date'];
    sId = json['S_id'];
    bStatus = json['B_status'];
    bTimesttr = json['B_timesttr'];
    bTimeEnd = json['B_time_end'];
    bHos = json['B_hos'];
    bFee = json['B_fee'];
    bDateSer = json['B_date_ser'];
    bPay = json['B_pay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adv_id'] = this.advId;
    data['B_id'] = this.bId;
    data['P_id'] = this.pId;
    data['N_id'] = this.nId;
    data['advice'] = this.advice;
    data['B_date'] = this.bDate;
    data['S_id'] = this.sId;
    data['B_status'] = this.bStatus;
    data['B_timesttr'] = this.bTimesttr;
    data['B_time_end'] = this.bTimeEnd;
    data['B_hos'] = this.bHos;
    data['B_fee'] = this.bFee;
    data['B_date_ser'] = this.bDateSer;
    data['B_pay'] = this.bPay;
    return data;
  }
}
