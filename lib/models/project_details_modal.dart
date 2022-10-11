class PunchLists {
  int? id;
  String? referenceId;
  int? projectId;
  int? userId;
  String? beforeImage;
  String? beforeDescription;
  String? expectedCompletionDate;
  String? afterImage;
  String? afterDescription;
  String? actualCompletionDate;
  String? status;
  String? createdAt;
  String? updatedAt;

  PunchLists({
    this.id,
    this.referenceId,
    this.projectId,
    this.userId,
    this.beforeImage,
    this.beforeDescription,
    this.expectedCompletionDate,
    this.afterImage,
    this.afterDescription,
    this.actualCompletionDate,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  PunchLists.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    referenceId = json['reference_id']?.toString();
    projectId = json['project_id']?.toInt();
    userId = json['user_id']?.toInt();
    beforeImage = json['before_image']?.toString();
    beforeDescription = json['before_description']?.toString();
    expectedCompletionDate = json['expected_completion_date']?.toString();
    afterImage = json['after_image']?.toString();
    afterDescription = json['after_description']?.toString();
    actualCompletionDate = json['actual_completion_date']?.toString();
    status = json['status']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['reference_id'] = referenceId;
    data['project_id'] = projectId;
    data['user_id'] = userId;
    data['before_image'] = beforeImage;
    data['before_description'] = beforeDescription;
    data['expected_completion_date'] = expectedCompletionDate;
    data['after_image'] = afterImage;
    data['after_description'] = afterDescription;
    data['actual_completion_date'] = actualCompletionDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Reports {
  String? name;
  String? createdAt;

  Reports({
    this.name,
    this.createdAt,
  });

  Reports.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    createdAt = json['created_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['created_at'] = createdAt;
    return data;
  }
}

class Maintenance {
  Maintenance();
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

class ProjectsDetail {
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
  List<ProjectCategory?>? projectCategory;

  ProjectsDetail({
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
    this.projectCategory,
  });

  ProjectsDetail.fromJson(Map<String, dynamic> json) {
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
    if (json['project_category'] != null) {
      final v = json['project_category'];
      final arr0 = <ProjectCategory>[];
      v.forEach((v) {
        arr0.add(ProjectCategory.fromJson(v));
      });
      projectCategory = arr0;
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
    if (projectCategory != null) {
      final v = projectCategory;
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
  List<ProjectsDetail?>? projectDetails;
  List<Reports?>? reports;
  List<Maintenance?>? maintenance;
  List<PunchLists?>? punchList;

  Data({
    this.projectDetails,
    this.reports,
    this.maintenance,
    this.punchList,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['project_details'] != null) {
      final v = json['project_details'];
      final arr0 = <ProjectsDetail>[];
      v.forEach((v) {
        arr0.add(ProjectsDetail.fromJson(v));
      });
      projectDetails = arr0;
    }
    if (json['reports'] != null) {
      final v = json['reports'];
      final arr0 = <Reports>[];
      v.forEach((v) {
        arr0.add(Reports.fromJson(v));
      });
      reports = arr0;
    }
    if (json['punch_list'] != null) {
      final v = json['punch_list'];
      final arr0 = <PunchLists>[];
      v.forEach((v) {
        arr0.add(PunchLists.fromJson(v));
      });
      punchList = arr0;
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
    if (reports != null) {
      final v = reports;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['reports'] = arr0;
    }
    if (punchList != null) {
      final v = punchList;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['punch_list'] = arr0;
    }
    return data;
  }
}

class ProjectDetailsModal {
  bool? success;
  String? message;
  Data? data;

  ProjectDetailsModal({
    this.success,
    this.message,
    this.data,
  });

  ProjectDetailsModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message']?.toString();
    data = (json['data'] != null) ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data!.toJson();
    return data;
  }
}
