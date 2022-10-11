class RequestBody {
  static Map projectList({String? search}) {
    return {
      'search': search,
    };
  }

  static Map projectDetails({String? projectId, String? search}) {
    return {
      'project_id': projectId,
      'report_search': search,
    };
  }

  static Map projectInfo({String? projectId}) {
    return {
      'project_id': projectId,
    };
  }

  static Map addSiteSurveyReport({
    String? projectId,
    String? length,
    String? width,
    String? area,
    String? onLoadingLocation,
    String? offLoadingLocation,
    int? reportId,
    String? description,
    String? layoutPlanImage,
    String? image360Degree,
  }) {
    return {
      'project_id': projectId,
      'length': length,
      'width': width,
      'area': area,
      'onloading_location': onLoadingLocation,
      'offloading_location': offLoadingLocation,
      'report_category_id': reportId,
      'description': description,
      'layout_plan_image': layoutPlanImage,
      'image_360_degree': image360Degree,
      'type': 'web',
    };
  }

  static Map editSiteSurveyReport({
    int? id,
    String? length,
    String? width,
    String? area,
    String? onLoadingLocation,
    String? offLoadingLocation,
    int? reportId,
    String? description,
    String? layoutPlanImage,
    String? image360Degree,
  }) {
    return {
      'id': id,
      'length': length,
      'width': width,
      'area': area,
      'onloading_location': onLoadingLocation,
      'offloading_location': offLoadingLocation,
      'report_category_id': reportId,
      'description': description,
      'layout_plan_image': layoutPlanImage,
      'image_360_degree': image360Degree,
      'type': 'web',
    };
  }
}
