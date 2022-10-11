class EditProfileModel {
  bool? success;
  String? message;
  Data? data;

  EditProfileModel({this.success, this.message, this.data});

  EditProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? employeeId;
  int? userRoleId;
  String? phone;
  String? address;
  String? photo;
  String? otp;
  int? isVerified;
  String? status;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.id,
        this.name,
        this.email,
        this.employeeId,
        this.userRoleId,
        this.phone,
        this.address,
        this.photo,
        this.otp,
        this.isVerified,
        this.status,
        this.updatedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    employeeId = json['employee_id'];
    userRoleId = json['user_role_id'];
    phone = json['phone'];
    address = json['address'];
    photo = json['photo'];
    otp = json['otp'];
    isVerified = json['is_verified'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['employee_id'] = this.employeeId;
    data['user_role_id'] = this.userRoleId;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['photo'] = this.photo;
    data['otp'] = this.otp;
    data['is_verified'] = this.isVerified;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
