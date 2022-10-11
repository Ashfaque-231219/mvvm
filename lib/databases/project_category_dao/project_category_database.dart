import 'package:floor/floor.dart';

@Entity(tableName: 'project_category')
class ProjectCategories {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'name')
  final String? name;
  @ColumnInfo(name: 'color')
  final String? color;
  @ColumnInfo(name: 'created_at')
  final String? createdAt;
  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  ProjectCategories(
      {
        this.id,
        this.name,
        this.color,
        this.createdAt,
        this.updatedAt
      });
  @override
  String toString() {
    return '{id: $id,name: $name,color:$color,createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
