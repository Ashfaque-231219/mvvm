import 'package:floor/floor.dart';
import 'package:redwood_app/databases/site_survey_reports_dao/survey_reports.dart';

@dao
abstract class SiteSurveyReportsDao {
  @insert
  Future<int> insertUser(SiteSurveyReports siteSurveyReports);

  @Query('UPDATE survey_reports SET layout_plan_image=:layoutPlanImage,description=:description,created_at=:createdAt,updated_at=:updatedAt WHERE id=:id')
  Future<SiteSurveyReports?> updateLayoutPlanImage(int id, String layoutPlanImage,String description,String createdAt,String updatedAt);

  @Query('UPDATE survey_reports SET image_360_degree=:image360Degree,report_category_id=:reportCategoryId,description=:description,created_at=:createdAt,updated_at=:updatedAt WHERE id=:id')
  Future<SiteSurveyReports?> update360Image(int id, String image360Degree,String reportCategoryId,String description,String createdAt,String updatedAt);

  @Query('SELECT * FROM survey_reports WHERE id= :id')
  Future<SiteSurveyReports?> getReportById(int id);

  @Query('SELECT * FROM survey_reports')
  Future<List<SiteSurveyReports?>> getAllSiteSurveyReport();

}
