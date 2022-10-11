class DashboardModel {
  bool? success;
  String? message;
  Data? data;

  DashboardModel({this.success, this.message, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
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
  String? currentDate;
  int? projectCount;
  List<ProjectDetails>? projectDetails;

  Data({this.currentDate, this.projectCount, this.projectDetails});

  Data.fromJson(Map<String, dynamic> json) {
    currentDate = json['current_date'];
    projectCount = json['project_count'];
    if (json['project_details'] != null) {
      projectDetails = <ProjectDetails>[];
      json['project_details'].forEach((v) {
        projectDetails!.add(new ProjectDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_date'] = this.currentDate;
    data['project_count'] = this.projectCount;
    if (this.projectDetails != null) {
      data['project_details'] =
          this.projectDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectDetails {
  int? id;
  String? projectName;
  String? address;
  String? logo;
  List<ProjectCategory>? projectCategory;

  ProjectDetails(
      {this.id,
        this.projectName,
        this.address,
        this.logo,
        this.projectCategory});

  ProjectDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['project_name'];
    address = json['address'];
    logo = json['logo'];
    if (json['project_category'] != null) {
      projectCategory = <ProjectCategory>[];
      json['project_category'].forEach((v) {
        projectCategory!.add(new ProjectCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_name'] = this.projectName;
    data['address'] = this.address;
    data['logo'] = this.logo;
    if (this.projectCategory != null) {
      data['project_category'] =
          this.projectCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectCategory {
  String? name;
  String? color;

  ProjectCategory({this.name, this.color});

  ProjectCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
}