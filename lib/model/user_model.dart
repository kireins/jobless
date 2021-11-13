/// id : "fZW6IPr9WEmLWvkHTflU"
/// name : "Daniel Seavey"
/// email : "Sdani@gmail.com"
/// password : "202111"
/// goal : "Be yours"

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.goal,});

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    goal = json['goal'];
  }
  String? id;
  String? name;
  String? email;
  String? password;
  String? goal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['goal'] = goal;
    return map;
  }

}