class GetServices {
  String idSer;
  String nameSer;
  String charge;

  GetServices({this.idSer, this.nameSer, this.charge});

  GetServices.fromJson(Map<String, dynamic> json) {
    idSer = json['id_ser'];
    nameSer = json['name_ser'];
    charge = json['charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_ser'] = this.idSer;
    data['name_ser'] = this.nameSer;
    data['charge'] = this.charge;
    return data;
  }
}
