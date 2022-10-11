import 'package:floor/floor.dart';
import 'package:redwood_app/databases/project_category_dao/project_category_database.dart';

@dao
abstract class ProjectCategoryDao {

  @insert
  Future<int> insertCategory(ProjectCategories projectCategory);

  @Query('SELECT * FROM project_category')
  Future<List<ProjectCategories>> getAllCategories();
}