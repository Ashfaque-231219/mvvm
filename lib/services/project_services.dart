import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:redwood_app/helper/constants/api_const.dart';
import 'package:redwood_app/helper/utils/shared_pref.dart';
import 'package:redwood_app/models/project_details_modal.dart';
import 'package:redwood_app/models/project_info_modal.dart';
import 'package:redwood_app/models/project_list_modal.dart';
import 'package:redwood_app/repositoreis/project_repository.dart';

class ProjectServices implements ProjectRepository {
  final Dio dio;

  ProjectServices({required this.dio});

  @override
  Future getProjectList(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConst.projectList, data: req);
      ProjectsListModel getProjectDetails = ProjectsListModel.fromJson(response.data);
      return getProjectDetails;
    } catch (e) {
      debugPrint(e.toString());
      // checkStatus(context);
      var msg = await SharedPref.getString(key: "error-msg");
    }
  }

  @override
  Future getProjectDetailsList(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConst.projectDetails, data: req);
      ProjectDetailsModal getProjectDetails = ProjectDetailsModal.fromJson(response.data);
      return getProjectDetails;
    } catch (e) {
      debugPrint(e.toString());

      var msg = await SharedPref.getString(key: "error-msg");
    }
  }

  @override
  Future getProjectInfo(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConst.projectInfo, data: req);
      ProjectInfoModal getProjectDetails = ProjectInfoModal.fromJson(response.data);
      return getProjectDetails;
    } catch (e) {
      debugPrint(e.toString());

      var msg = await SharedPref.getString(key: "error-msg");
    }
  }
}
