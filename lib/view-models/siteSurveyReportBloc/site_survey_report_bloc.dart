import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/databases/database.dart';
import 'package:redwood_app/databases/site_survey_reports_dao/survey_reports.dart';
import 'package:redwood_app/models/site_survey_report_modal.dart';
import 'package:redwood_app/repositoreis/report_repository.dart';
import 'package:redwood_app/services/request_body.dart';

import '../../helper/utils/shared_pref.dart';
import '../../models/report_list_modal.dart';

part 'site_survey_report_event.dart';

part 'site_survey_report_state.dart';

class SiteSurveyReportBloc extends Bloc<SiteSurveyReportEvent, SiteSurveyReportState> {
  ReportRepository reportRepository;
  Dio? dio;

  SiteSurveyReportBloc({
    required this.reportRepository,
    this.dio,
    AppDatabase? database,
  }) : super(SiteSurveyReportInitial()) {
    on<AddSiteFormReportEvent>((event, emit) async {
      await _addReportEvent(event, emit);
    });
    on<AddSiteSurveyFormEvent>((event, emit) async {
      await _addSiteSurveyFormEvent(event, emit, database);
    });
    on<GetReportByIdEvents>((event, emit) async {
      await _getReportByIdEvent(event, emit, database);
    });
  }

  _addReportEvent(AddSiteFormReportEvent event, Emitter<SiteSurveyReportState> emit) async {
    emit(Loading());
    late BuildContext dialogContext; // global declaration
    // Future.delayed(Duration.zero, () {
    //   return showDialog(
    //       context: event.context,
    //       builder: (context) {
    //         dialogContext = context;
    //         return const CustomProgressIndicator();
    //       });
    // });

    try {
      Map req = RequestBody.addSiteSurveyReport(
          projectId: event.projectId,
          length: event.length,
          width: event.width,
          area: event.area,
          onLoadingLocation: event.onLoadingLocation,
          offLoadingLocation: event.offLoadingLocation,
          reportId: event.reportId,
          description: event.description,
          layoutPlanImage: event.layoutPlanImage,
          image360Degree: event.image360Degree);

      debugPrint("req");
      debugPrint(req.toString());

      SiteSurveyModal? reportType = await reportRepository.addSiteSurveyReportService(req, event.context);
      if (reportType!.success!) {
        emit(AddSiteSurveyReportState(reportName: reportType));
      } else {
        // Future.delayed(Duration.zero, () {
        //   Navigator.pop(dialogContext);
        // });
        debugPrint("error");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _addSiteSurveyFormEvent(AddSiteSurveyFormEvent event, Emitter<SiteSurveyReportState> emit, AppDatabase? database) async {
    try {
      int reportTypeId = await SharedPref.getInt(key: "reportTypeId");
      int? reportId = await database?.siteSurveyReportsDao.insertUser(SiteSurveyReports(
          reportId: reportTypeId,
          length: event.length,
          width: event.width,
          onloadingLocation: event.onloadingLocation,
          offloadingLocation: event.offloadingLocation,
          createdAt: DateTime.now().toString(),
          updatedAt: DateTime.now().toString()));

      await SharedPref.setInt(key: "reportId", data: reportId ?? 0);
    } catch (e) {
      print(e.toString());
    }
  }

  _getReportByIdEvent(GetReportByIdEvents event, Emitter<SiteSurveyReportState> emit, AppDatabase? database) async {
    try {
      SiteSurveyReports? reportsDetails = await database?.siteSurveyReportsDao.getReportById(event.id ?? 0);
      print("reportdetails ====$reportsDetails");

      // emit(state.copyWith(reportDetails: reportsDetails));
    } catch (e) {
      print(e.toString());
    }
  }
}
