part of 'site_survey_report_bloc.dart';

abstract class SiteSurveyReportEvent extends Equatable {
  const SiteSurveyReportEvent();
  @override
  List<Object?> get props => [];
}

class AddSiteFormReportEvent extends SiteSurveyReportEvent{
  final String? projectId;
  final String? length;
  final String? width;
  final String? area;
  final String? onLoadingLocation;
  final String? offLoadingLocation;
  final int? reportId;
  final String? description;
  final String? layoutPlanImage;
  final String? image360Degree;
  final BuildContext context;

  const AddSiteFormReportEvent(
      {required this.projectId,
        required this.length,
        required this.width,
        required this.area,
        required this.onLoadingLocation,
        required this.offLoadingLocation,
        required this.reportId,
        required this.description,
        required this.layoutPlanImage,
        required this.image360Degree,
        required this.context});

  @override
  List<Object?> get props =>[];
}
class GetReportListEvent extends SiteSurveyReportEvent {
  final BuildContext context;
  final String? search;

  const GetReportListEvent({required this.context, this.search});
}
class AddSiteSurveyFormEvent extends SiteSurveyReportEvent {
  final String? length;
  final String? width;
  final String? onloadingLocation;
  final String? offloadingLocation;
  final String? createdAt;
  final String? updatedAt;


  AddSiteSurveyFormEvent({
    this.length,
    this.width,
    this.onloadingLocation,
    this.offloadingLocation,
    this.createdAt,
    this.updatedAt
  });

  @override
  List<Object?> get props => [];
}
class GetReportByIdEvents extends SiteSurveyReportEvent {
  final int? id;

  const GetReportByIdEvents({required this.id});

  @override
  List<Object?> get props => [];
}