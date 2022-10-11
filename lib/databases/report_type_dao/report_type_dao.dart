import 'package:floor/floor.dart';
import 'package:redwood_app/databases/report_dao/report_database.dart';
import 'package:redwood_app/databases/report_type_dao/report_type_database.dart';

@dao
abstract class ReportTypeDao {
  @insert
  Future<int> insertReportType(GetReportType reportType);

  @Query('SELECT * FROM report_type')
  Future<List<GetReportType>> getAllReports();

 @Query('SELECT report_id FROM report_type')
  Future<List<int?>?> getAllReportsId();

  @Query('SELECT * FROM report_type WHERE id= :id')
  Future<GetReportType?> getReportTypeById(int id);


  @Query('UPDATE report_type SET report_id=:reportId WHERE id=:id')
  Future<GetReportType?> updateReportId(int id, int reportId );
}