import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:redwood_app/helper/constants/api_const.dart';
import 'package:redwood_app/helper/utils/shared_pref.dart';
import 'package:redwood_app/models/report_list_modal.dart';
import 'package:redwood_app/models/site_survey_report_modal.dart';
import 'package:redwood_app/repositoreis/report_repository.dart';

class ReportServices implements ReportRepository {
  final Dio dio;

  ReportServices({required this.dio});

  @override
  Future reportListService(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConst.reportsList, data: req);
      ReportListModal reportList = ReportListModal.fromJson(response.data);
      return reportList;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future addSiteSurveyReportService(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConst.addSiteSurveyReport, data: req);
      SiteSurveyModal report = SiteSurveyModal.fromJson(response.data);
      return report;
    } catch (e) {
      debugPrint(e.toString());

      var msg = await SharedPref.getString(key: "error-msg");
    }
  }

  @override
  Future editSiteSurveyReportService(Map req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConst.editSiteSurveyReport, data: req);
      SiteSurveyModal report = SiteSurveyModal.fromJson(response.data);
      debugPrint(report.toString());
      return report;
    } catch (e) {
      debugPrint(e.toString());

      var msg = await SharedPref.getString(key: "error-msg");
    }
  }
}
