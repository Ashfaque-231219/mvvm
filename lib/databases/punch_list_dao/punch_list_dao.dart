import 'package:floor/floor.dart';
import 'package:redwood_app/databases/punch_list_dao/punch_list_database.dart';
import 'package:redwood_app/databases/report_dao/report_database.dart';

@dao
abstract class PunchListDao {
  @insert
  Future<int> insertPunchList(PunchList punchList);

  @Query('SELECT * FROM punch_list WHERE id= :id')
  Future<PunchList?> getPunchListById(int id);

  @Query('SELECT * FROM punch_list')
  Future<List<PunchList>> getAllIssues();

  @Query('SELECT status FROM punch_list')
  Future<List<PunchList>> getAllStatus();

  @Query('UPDATE punch_list SET after_image=:afterImage,after_description=:afterDescription,actual_completion_date=:actualCompletionDate,status=:status,created_at=:createdAt,updated_at=:updatedAt WHERE id=:id')
  Future<PunchList?> resolvePunchList(int id, String afterImage,String afterDescription,String actualCompletionDate,String createdAt,String updatedAt,String status);



}