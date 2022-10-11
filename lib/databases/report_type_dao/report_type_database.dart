import 'package:floor/floor.dart';

@Entity(tableName: 'report_type')
class GetReportType {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'report_name')
  final String? reportName;
  @ColumnInfo(name: 'report_id')
  final int? reportId;
  @ColumnInfo(name: 'created_at')
  final String? createdAt;
  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  GetReportType(
      {
        this.id,
        this.reportId,
        this.reportName,
        this.createdAt,
        this.updatedAt
      });
  @override
  String toString() {
    return '{id: $id,reportName: $reportName,reportId:$reportId,createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
