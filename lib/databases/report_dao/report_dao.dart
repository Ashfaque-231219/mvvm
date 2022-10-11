import 'package:floor/floor.dart';
import 'package:redwood_app/databases/report_dao/report_database.dart';

@dao
abstract class ReportDao {
  @insert
  Future<int> insertReport(Report report);

  @Query('SELECT * FROM report')
  Future<List<Report>> getAllReports();
}