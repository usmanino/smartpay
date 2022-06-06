class UserModel {
  String? id;
  String? full_name;
  String? username;
  String? email;
  String? password;
  int? phone;
  int? phoneCountry;
  String? country;
  String? device_name;
  int? avatar;

  UserModel({
    this.full_name,
    this.email,
    this.username,
    this.password,
    this.phone,
    this.phoneCountry,
    this.country,
    this.avatar,
    this.device_name,
    this.id,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    full_name = json['full_name'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    phone = json['phone'];
    phoneCountry = json['phoneCountry'];
    country = json['country'];
    device_name = json['device_name'];
    avatar = json['avatar'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['full_name'] = full_name;
    data['email'] = email;
    data['username'] = username ?? '';
    data['password'] = password;
    data['phone'] = phone ?? '';
    data['phoneCountry'] = phoneCountry ?? '';
    data['country'] = country;
    data['deviceName'] = device_name;
    data['avatar'] = avatar ?? '';
    data['id'] = id ?? '';

    return data;
  }
}
