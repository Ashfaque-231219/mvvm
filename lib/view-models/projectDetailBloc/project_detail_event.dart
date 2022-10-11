part of 'project_detail_bloc.dart';

abstract class ProjectDetailEvent extends Equatable {
  const ProjectDetailEvent();

  @override
  List<Object?> get props => [];
}

class GetReportTypeEvent extends ProjectDetailEvent {
  final BuildContext context;

  const GetReportTypeEvent({required this.context});
}

class GetProjectListEvent extends ProjectDetailEvent {
  final BuildContext context;
  final String? search;

  const GetProjectListEvent({required this.context, this.search});
}

class GetProjectDetailsEvent extends ProjectDetailEvent {
  final BuildContext context;
  final String? projectId;
  final String? search;

  const GetProjectDetailsEvent({required this.context, required this.projectId, this.search});
}

class GetProjectInfoEvent extends ProjectDetailEvent {
  final BuildContext context;
  final String? projectId;

  const GetProjectInfoEvent({required this.context, required this.projectId});
}
