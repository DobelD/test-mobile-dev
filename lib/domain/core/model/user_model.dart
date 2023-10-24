class UserModel {
  String? name;
  String? email;
  String? picture;

  UserModel({this.name, this.email, this.picture});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['picture'] = picture;
    return data;
  }
}
