import 'package:floor/floor.dart';

@Entity(tableName: 'punch_list')
class PunchList {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'before_image')
  final String? beforeImage;
  @ColumnInfo(name: 'reference_id')
  final int? referenceId;
  @ColumnInfo(name: 'after_image')
  final String? afterImage;
  @ColumnInfo(name: 'before_description')
  final String? beforeDescription;
  @ColumnInfo(name: 'after_description')
  final String? afterDescription;
  @ColumnInfo(name: 'expected_completion_date')
  final String? expectedCompletionDate;
  @ColumnInfo(name: 'actual_completion_date')
  final String? actualCompletionDate;
  final String? status;
  @ColumnInfo(name: 'created_at')
  final String? createdAt;
  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  PunchList(
      {
        this.id,
        this.status,
        this.referenceId,
        this.actualCompletionDate,
        this.afterDescription,
        this.afterImage,
        this.beforeDescription,
        this.beforeImage,
        this.expectedCompletionDate,
        this.createdAt,
        this.updatedAt
      });
  @override
  String toString() {
    return '{id: $id,afterImage:$afterImage,referenceId:$referenceId,beforeDescription:$beforeDescription,expectedCompletionDate:$expectedCompletionDate,beforeImage:$beforeImage,status: $status,actualCompletionDate:$actualCompletionDate,afterDescription:$afterDescription,createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
