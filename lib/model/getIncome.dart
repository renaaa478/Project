class GetIncome {
  String inCareId;
  String nId;
  String bId;
  String price;
  String bDate;

  GetIncome({this.inCareId, this.nId, this.bId, this.price, this.bDate});

  GetIncome.fromJson(Map<String, dynamic> json) {
    inCareId = json['in_care_id'];
    nId = json['N_id'];
    bId = json['B_id'];
    price = json['price'];
    bDate = json['B_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['in_care_id'] = this.inCareId;
    data['N_id'] = this.nId;
    data['B_id'] = this.bId;
    data['price'] = this.price;
    data['B_date'] = this.bDate;
    return data;
  }
}
