class ReportListModal {
  bool? success;
  String? message;
  Data? data;

  ReportListModal({
    this.success,
    this.message,
    this.data,
  });

  ReportListModal.fromJson(Map<String, dynamic> json) {
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

class Data {
  List<ProjectDetail?>? projectDetails;

  Data({
    this.projectDetails,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['project_details'] != null) {
      final v = json['project_details'];
      final arr0 = <ProjectDetail>[];
      v.forEach((v) {
        arr0.add(ProjectDetail.fromJson(v));
      });
      projectDetails = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (projectDetails != null) {
      final v = projectDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['project_details'] = arr0;
    }
    return data;
  }
}

class ProjectDetail {
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
  int? projectId;
  int? userId;
  String? length;
  String? width;
  String? area;
  String? onloadingLocation;
  String? offloadingLocation;
  String? layoutPlanImage;
  String? the360DegreeImage;
  int? reportCategoryId;
  String? reportName;

  ProjectDetail({
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
    this.projectId,
    this.userId,
    this.length,
    this.width,
    this.area,
    this.onloadingLocation,
    this.offloadingLocation,
    this.layoutPlanImage,
    this.the360DegreeImage,
    this.reportCategoryId,
    this.reportName,
  });

  ProjectDetail.fromJson(Map<String, dynamic> json) {
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
    projectId = json['project_id']?.toInt();
    userId = json['user_id']?.toInt();
    length = json['length']?.toString();
    width = json['width']?.toString();
    area = json['area']?.toString();
    onloadingLocation = json['onloading_location']?.toString();
    offloadingLocation = json['offloading_location']?.toString();
    layoutPlanImage = json['layout_plan_image']?.toString();
    the360DegreeImage = json['360_degree_image']?.toString();
    reportCategoryId = json['report_category_id']?.toInt();
    reportName = json['report_name']?.toString();
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
    data['project_id'] = projectId;
    data['user_id'] = userId;
    data['length'] = length;
    data['width'] = width;
    data['area'] = area;
    data['onloading_location'] = onloadingLocation;
    data['offloading_location'] = offloadingLocation;
    data['layout_plan_image'] = layoutPlanImage;
    data['360_degree_image'] = the360DegreeImage;
    data['report_category_id'] = reportCategoryId;
    data['report_name'] = reportName;
    return data;
  }
}
