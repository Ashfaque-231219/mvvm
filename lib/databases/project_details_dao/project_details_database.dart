import 'package:floor/floor.dart';

import '../project_category_dao/project_category_database.dart';

@Entity(tableName: 'project_details')
class ProjectDetail {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'project_name')
  final String? projectName;
  @ColumnInfo(name: 'address')
  final String? address;
  @ColumnInfo(name: 'logo')
  final String? logo;
  @ForeignKey(
      childColumns: ['color'],
      parentColumns: ['id'],
      entity: ProjectCategories)
  @ForeignKey(
      childColumns: ['name'],
      parentColumns: ['id'],
      entity: ProjectCategories)
  @ColumnInfo(name: 'created_at')
  final String? createdAt;
  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  ProjectDetail(
      {
        this.id,
        this.projectName,
        this.address,
        this.updatedAt,
        this.logo,
        this.createdAt

      });
  @override
  String toString() {
    return '{id: $id,reportName: $projectName,address:$address,logo:$logo,createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
