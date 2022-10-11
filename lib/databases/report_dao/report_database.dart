import 'package:floor/floor.dart';

@Entity(tableName: 'report')
class Report {
  @PrimaryKey(autoGenerate: true)
  final int? id;
 @ColumnInfo(name: 'report_name')
  final String? reportName;
  @ColumnInfo(name: 'created_at')
  final String? createdAt;
  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  Report(
      {
        this.id,
        this.reportName,
        this.createdAt,
        this.updatedAt
      });
  @override
  String toString() {
    return '{id: $id,reportName: $reportName,createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
