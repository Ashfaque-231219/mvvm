part of 'project_detail_bloc.dart';

abstract class ProjectDetailState extends Equatable {
  const ProjectDetailState();

  @override
  List<Object?> get props => [];
}

class ProjectDetailInitial extends ProjectDetailState {}

class Loading extends ProjectDetailState {}

class GetReportTypeState extends ProjectDetailState {
  final List<ReportType>? reportName;

  const GetReportTypeState({this.reportName});

  GetReportTypeState copyWith({
    final List<ReportType>? reportName,
  }) {
    return GetReportTypeState(reportName: reportName ?? this.reportName);
  }

  @override
  String toString() {
    return "GetReportTypeState{reportName:$reportName}";
  }
}

class GetProjectListState extends ProjectDetailState {
  final ProjectsListModel? projectList;

  const GetProjectListState({this.projectList});

  GetProjectListState copyWith({
    final ProjectsListModel? projectList,
  }) {
    return GetProjectListState(projectList: projectList ?? this.projectList);
  }

  @override
  String toString() {
    return "ProjectsListState{projectList:$projectList}";
  }

  @override
  List<Object?> get props => [projectList];
}

class GetProjectDetailsState extends ProjectDetailState {
  final ProjectDetailsModal? projectDetails;

  const GetProjectDetailsState({this.projectDetails});

  GetProjectDetailsState copyWith({
    final ProjectDetailsModal? projectDetails,
  }) {
    return GetProjectDetailsState(projectDetails: projectDetails ?? this.projectDetails);
  }

  @override
  String toString() {
    return "ProjectsDetailsState{projectList:$projectDetails}";
  }

  @override
  List<Object?> get props => [projectDetails];
}

class GetProjectInfoState extends ProjectDetailState {
  final ProjectInfoModal? projectDetails;

  const GetProjectInfoState({this.projectDetails});

  GetProjectInfoState copyWith({
    final ProjectInfoModal? projectDetails,
  }) {
    return GetProjectInfoState(projectDetails: projectDetails ?? this.projectDetails);
  }

  @override
  String toString() {
    return "ProjectsInfoState{projectList:$projectDetails}";
  }

  @override
  List<Object?> get props => [projectDetails];
}
