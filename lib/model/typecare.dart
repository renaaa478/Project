class Gettypecare {
  String nnId;
  String nnName;
  String sCharge;

  Gettypecare({this.nnId, this.nnName, this.sCharge});

  Gettypecare.fromJson(Map<String, dynamic> json) {
    nnId = json['Nn_id'];
    nnName = json['Nn_name'];
    sCharge = json['S_charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Nn_id'] = this.nnId;
    data['Nn_name'] = this.nnName;
    data['S_charge'] = this.sCharge;
    return data;
  }
}
