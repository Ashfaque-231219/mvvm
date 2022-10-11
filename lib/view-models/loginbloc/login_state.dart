
import 'package:redwood_app/databases/project_details_dao/project_details_database.dart';
import 'package:redwood_app/databases/site_survey_reports_dao/survey_reports.dart';

import '../../databases/punch_list_dao/punch_list_database.dart';
import '../../databases/report_dao/report_database.dart';
import '../../models/login/get_report_type.dart';
import '../../models/login/login_modal.dart';
import '../../models/user_details.dart';
import '../event_status.dart';

class LoginState {
  final LoginModal? loginModel;
  final UserDetail? userDetail;
  final StateStatus stateStatus;
  final String? name;
  final String? date;
  final String? email;
  final String? image;
  final String? status;
  final List<Report>? getAllReportType;
  final List<ReportType>? reportName;
  final SiteSurveyReports? reportDetails;
  final List<SiteSurveyReports?>? SitesurveyreportDetails;
  final List<ProjectDetail?>? projectDetailList;
  final List<PunchList?>? punchListDetails;
  final List<PunchList?>? openPunchList;
  final List<PunchList?>? closePunchList;
  final PunchList? punchList;


  LoginState(
      {this.loginModel,
      this.stateStatus = const StateNotLoaded(),
      this.name,
      this.date,
      this.email,
      this.image,
      this.userDetail,
        this.getAllReportType,
        this.reportName,
        this.reportDetails,
        this.SitesurveyreportDetails,
        this.projectDetailList,
        this.punchListDetails,
        this.status,
        this.closePunchList,
        this.openPunchList,
        this.punchList
      });

  LoginState copyWith(
      {final bool? successMsg,
      final String? name,
        final UserDetail? userDetail,
        final List<Report>? getAllReportType,
        final List<ReportType>? reportName,
        final String? date,
      final String? email,
      final String? image,
      final LoginModal? loginModel,
      final StateStatus? stateStatus,
        final SiteSurveyReports? reportDetails,
        final List<SiteSurveyReports?>? SitesurveyreportDetails,
        final List<ProjectDetail?>? projectDetailList,
        final List<PunchList?>? punchListDetails,
        final String? status,
        final List<PunchList?>? openPunchList,
        final List<PunchList?>? closePunchList,
        final PunchList? punchList,

      }) {
    return LoginState(
        loginModel: loginModel ?? this.loginModel,
        stateStatus: stateStatus ?? this.stateStatus,
        date: date ?? this.date,
        name: name ?? this.name,
        email: email ?? this.email,
        image: image ?? this.image,
    userDetail: userDetail??this.userDetail,
      getAllReportType: getAllReportType ?? this.getAllReportType,
      reportName: reportName ?? this.reportName,
      reportDetails:  reportDetails ?? this.reportDetails,
      SitesurveyreportDetails: SitesurveyreportDetails ?? this.SitesurveyreportDetails,
      projectDetailList: projectDetailList ?? this.projectDetailList,
      punchListDetails: punchListDetails ?? this.punchListDetails,
        status : status ?? this.status,
      openPunchList: openPunchList ?? this.openPunchList,
      closePunchList: closePunchList ?? this.closePunchList,
      punchList: punchList ?? this.punchList
    );
  }

  @override
  String toString() {
    return "LoginState{successMsg:loginModel:$loginModel,punchList:$punchList,closePunchList:$closePunchList,openPunchList:$openPunchList,status:$status,punchListDetails:$punchListDetails,projectDetailList:$projectDetailList,SitesurveyreportDetails:$SitesurveyreportDetails,reportDetails:$reportDetails,reportName:$reportName,name:$name,date:$date,email:$email,image:$image,getAllReportType:$getAllReportType,userDetail:$userDetail}";
  }
}
