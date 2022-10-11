class LoginModal {
  LoginModal({
    required this.success,
    required this.message,
    required this.token,
    required this.data,
  });

  late final bool success;
  late final String message;
  late final String token;
  late final Data data;

  LoginModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['token'] = token;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.countryId,
    required this.address,
    this.brand,
    this.officeNumber,
    this.position,
    this.team,
    this.region,
    required this.userRoleId,
    required this.employeeId,
    required this.photo,
    this.otp,
    required this.isVerified,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
  });

  late final int id;
  late final String name;
  late final String email;
  late final String phone;
  late final Null countryId;
  late final String address;
  late final Null brand;
  late final Null officeNumber;
  late final Null position;
  late final Null team;
  late final Null region;
  late final String userRoleId;
  late final String employeeId;
  late final String photo;
  late final Null otp;
  late final int isVerified;
  late final String status;
  late final String updatedAt;
  late final String createdAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    countryId = null;
    address = json['address'];
    brand = null;
    officeNumber = null;
    position = null;
    team = null;
    region = null;
    userRoleId = json['user_role_id'];
    employeeId = json['employee_id'];
    photo = json['photo'];
    otp = null;
    isVerified = json['is_verified'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['country_id'] = countryId;
    _data['address'] = address;
    _data['brand'] = brand;
    _data['office_number'] = officeNumber;
    _data['position'] = position;
    _data['team'] = team;
    _data['region'] = region;
    _data['user_role_id'] = userRoleId;
    _data['employee_id'] = employeeId;
    _data['photo'] = photo;
    _data['otp'] = otp;
    _data['is_verified'] = isVerified;
    _data['status'] = status;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = createdAt;
    return _data;
  }
}
