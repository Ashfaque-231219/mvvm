import 'package:floor/floor.dart';

@Entity(tableName: 'survey_reports')
class SiteSurveyReports {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'report_id')
  final int? reportId;
  final String? length;
  final String? width;
  @ColumnInfo(name: 'onloading_location')
  final String? onloadingLocation;
  @ColumnInfo(name: 'offloading_location')
  final String? offloadingLocation;
  @ColumnInfo(name: 'layout_plan_image')
  final String? layoutPlanImage;
  final String? description;
  @ColumnInfo(name: 'image_360_degree')
  final String? image360Degree;
  @ColumnInfo(name: 'report_category_id')
  final String? reportCategoryId;
  @ColumnInfo(name: 'created_at')
  final String? createdAt;
  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  SiteSurveyReports(
      {
        this.id,
        this.reportId,
      this.length,
      this.width,
      this.onloadingLocation,
      this.offloadingLocation,
      this.layoutPlanImage,
      this.description,
      this.createdAt,
      this.image360Degree,
      this.reportCategoryId,
      this.updatedAt
      });
  @override
  String toString() {
    return '{id: $id,reportId:$reportId, length: $length, width: $width, onloadingLocation: $onloadingLocation, offloadingLocation: $offloadingLocation, layoutPlanImage: $layoutPlanImage, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, image360Degree: $image360Degree, reportCategoryId: $reportCategoryId}';
  }
}
