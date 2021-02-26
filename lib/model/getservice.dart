class GetService {
  String serId;
  String serTime;
  String serHr;
  String serLo;
  String serCharge;
  String nnId;
  String idSer;

  GetService(
      {this.serId,
      this.serTime,
      this.serHr,
      this.serLo,
      this.serCharge,
      this.nnId,
      this.idSer});

  GetService.fromJson(Map<String, dynamic> json) {
    serId = json['Ser_id'];
    serTime = json['Ser_time'];
    serHr = json['Ser_hr'];
    serLo = json['Ser_lo'];
    serCharge = json['Ser_charge'];
    nnId = json['Nn_id'];
    idSer = json['id_ser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Ser_id'] = this.serId;
    data['Ser_time'] = this.serTime;
    data['Ser_hr'] = this.serHr;
    data['Ser_lo'] = this.serLo;
    data['Ser_charge'] = this.serCharge;
    data['Nn_id'] = this.nnId;
    data['id_ser'] = this.idSer;
    return data;
  }
}
