import 'package:floor/floor.dart';
import 'package:redwood_app/databases/project_details_dao/project_details_database.dart';

@dao
abstract class ProjectDetailDao {

  @insert
  Future<int> insertProject(ProjectDetail projectDetail);

  @Query('SELECT * FROM project_details')
  Future<List<ProjectDetail>> getAllProject();

}