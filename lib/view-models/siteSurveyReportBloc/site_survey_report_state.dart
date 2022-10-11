part of 'site_survey_report_bloc.dart';

abstract class SiteSurveyReportState extends Equatable {
  const SiteSurveyReportState();

  @override
  List<Object> get props => [];
}

class SiteSurveyReportInitial extends SiteSurveyReportState {
  @override
  List<Object> get props => [];
}

class Loading extends SiteSurveyReportState {
  @override
  List<Object> get props => [];
}

class GetReportsListState extends SiteSurveyReportState {
  final ReportListModal? reportList;

  const GetReportsListState({this.reportList});

  GetReportsListState copyWith({
    final ReportListModal? reportList,
  }) {
    return GetReportsListState(reportList: reportList ?? this.reportList);
  }

  @override
  String toString() {
    return "ReportsListState{reportList:$reportList}";
  }
}

class AddSiteSurveyReportState extends SiteSurveyReportState {
  final SiteSurveyModal? reportName;

  const AddSiteSurveyReportState({this.reportName});

  AddSiteSurveyReportState copyWith({
    final SiteSurveyModal? reportName,
  }) {
    return AddSiteSurveyReportState(reportName: reportName ?? this.reportName);
  }

  @override
  String toString() {
    return "ProjectDetailState{reportName:$reportName}";
  }
}
