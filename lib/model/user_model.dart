class UserModel {
  String id;
  String chooseType;
  String name;
  String surname;
  String user;
  String password;
  String status;

  UserModel(
      {this.id,
      this.chooseType,
      this.name,
      this.surname,
      this.user,
      this.password,
      this.status});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chooseType = json['chooseType'];
    name = json['name'];
    surname = json['surname'];
    user = json['user'];
    password = json['password'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chooseType'] = this.chooseType;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['user'] = this.user;
    data['password'] = this.password;
    data['status'] = this.status;
    return data;
  }
}
