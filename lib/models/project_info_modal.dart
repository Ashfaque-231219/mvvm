class Pivot {
  int? projectId;
  int? userId;

  Pivot({
    this.projectId,
    this.userId,
  });

  Pivot.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id']?.toInt();
    userId = json['user_id']?.toInt();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['project_id'] = projectId;
    data['user_id'] = userId;
    return data;
  }
}

class ProjectCategory {
  String? name;
  String? color;

  ProjectCategory({
    this.name,
    this.color,
  });

  ProjectCategory.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    color = json['color']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['color'] = color;
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? countryId;
  String? address;
  String? brand;
  String? officeNumber;
  String? position;
  String? team;
  String? region;
  String? userRoleId;
  String? employeeId;
  String? photo;
  String? otp;
  int? isVerified;
  String? status;
  String? updatedAt;
  String? createdAt;
  Pivot? pivot;

  Users({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.countryId,
    this.address,
    this.brand,
    this.officeNumber,
    this.position,
    this.team,
    this.region,
    this.userRoleId,
    this.employeeId,
    this.photo,
    this.otp,
    this.isVerified,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.pivot,
  });

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    email = json['email']?.toString();
    phone = json['phone']?.toString();
    countryId = json['country_id']?.toString();
    address = json['address']?.toString();
    brand = json['brand']?.toString();
    officeNumber = json['office_number']?.toString();
    position = json['position']?.toString();
    team = json['team']?.toString();
    region = json['region']?.toString();
    userRoleId = json['user_role_id']?.toString();
    employeeId = json['employee_id']?.toString();
    photo = json['photo']?.toString();
    otp = json['otp']?.toString();
    isVerified = json['is_verified']?.toInt();
    status = json['status']?.toString();
    updatedAt = json['updated_at']?.toString();
    createdAt = json['created_at']?.toString();
    pivot = (json['pivot'] != null) ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['country_id'] = countryId;
    data['address'] = address;
    data['brand'] = brand;
    data['office_number'] = officeNumber;
    data['position'] = position;
    data['team'] = team;
    data['region'] = region;
    data['user_role_id'] = userRoleId;
    data['employee_id'] = employeeId;
    data['photo'] = photo;
    data['otp'] = otp;
    data['is_verified'] = isVerified;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class ProjectDetails {
  int? id;
  String? projectCode;
  String? projectName;
  String? categoryId;
  String? title;
  String? image;
  String? logo;
  String? address;
  String? description;
  String? projectStartDate;
  String? projectEndDate;
  String? projectStatus;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Users?>? users;
  List<ProjectCategory?>? projectCategories;

  ProjectDetails({
    this.id,
    this.projectCode,
    this.projectName,
    this.categoryId,
    this.title,
    this.image,
    this.logo,
    this.address,
    this.description,
    this.projectStartDate,
    this.projectEndDate,
    this.projectStatus,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.users,
    this.projectCategories,
  });

  ProjectDetails.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    projectCode = json['project_code']?.toString();
    projectName = json['project_name']?.toString();
    categoryId = json['category_id']?.toString();
    title = json['title']?.toString();
    image = json['image']?.toString();
    logo = json['logo']?.toString();
    address = json['address']?.toString();
    description = json['description']?.toString();
    projectStartDate = json['project_start_date']?.toString();
    projectEndDate = json['project_end_date']?.toString();
    projectStatus = json['project_status']?.toString();
    status = json['status']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    if (json['users'] != null) {
      final v = json['users'];
      final arr0 = <Users>[];
      v.forEach((v) {
        arr0.add(Users.fromJson(v));
      });
      users = arr0;
    }
    if (json['project_category'] != null) {
      final v = json['project_category'];
      final arr0 = <ProjectCategory>[];
      v.forEach((v) {
        arr0.add(ProjectCategory.fromJson(v));
      });
      projectCategories = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['project_code'] = projectCode;
    data['project_name'] = projectName;
    data['category_id'] = categoryId;
    data['title'] = title;
    data['image'] = image;
    data['logo'] = logo;
    data['address'] = address;
    data['description'] = description;
    data['project_start_date'] = projectStartDate;
    data['project_end_date'] = projectEndDate;
    data['project_status'] = projectStatus;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (users != null) {
      final v = users;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['users'] = arr0;
    }
    if (projectCategories != null) {
      final v = projectCategories;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['project_category'] = arr0;
    }
    return data;
  }
}

class Data {
  List<ProjectDetails?>? projectDetails;

  Data({
    this.projectDetails,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['project_details'] != null) {
      final v = json['project_details'];
      final arr0 = <ProjectDetails>[];
      v.forEach((v) {
        arr0.add(ProjectDetails.fromJson(v));
      });
      projectDetails = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (projectDetails != null) {
      final v = projectDetails;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['project_details'] = arr0;
    }
    return data;
  }
}

class ProjectInfoModal {
  bool? success;
  String? message;
  Data? data;

  ProjectInfoModal({
    this.success,
    this.message,
    this.data,
  });

  ProjectInfoModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
