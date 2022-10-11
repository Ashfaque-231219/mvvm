import 'dart:async';

import 'package:floor/floor.dart';
import 'package:redwood_app/databases/project_category_dao/project_category_dao.dart';
import 'package:redwood_app/databases/project_category_dao/project_category_database.dart';
import 'package:redwood_app/databases/project_details_dao/project_details_dao.dart';
import 'package:redwood_app/databases/project_details_dao/project_details_database.dart';
import 'package:redwood_app/databases/punch_list_dao/punch_list_dao.dart';
import 'package:redwood_app/databases/punch_list_dao/punch_list_database.dart';
import 'package:redwood_app/databases/report_dao/report_dao.dart';
import 'package:redwood_app/databases/report_dao/report_database.dart';
import 'package:redwood_app/databases/report_type_dao/report_type_dao.dart';
import 'package:redwood_app/databases/report_type_dao/report_type_database.dart';
import 'package:redwood_app/databases/site_survey_reports_dao/survey_reports.dart';
import 'package:redwood_app/databases/site_survey_reports_dao/survey_reports_dao.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';


@Database(version: 1, entities: [SiteSurveyReports,GetReportType,Report,ProjectDetail,ProjectCategories,PunchList])
abstract class AppDatabase extends FloorDatabase{
  SiteSurveyReportsDao get siteSurveyReportsDao;
  ReportTypeDao get reportTypeDao;
  ReportDao get reportDao;
  ProjectDetailDao get projectDetailDao;
  ProjectCategoryDao get projectCategoryDao;
  PunchListDao get punchListDao;
}