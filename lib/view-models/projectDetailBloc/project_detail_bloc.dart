import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/models/get_report_type.dart';
import 'package:redwood_app/models/project_details_modal.dart';
import 'package:redwood_app/models/project_info_modal.dart';
import 'package:redwood_app/models/project_list_modal.dart';
import 'package:redwood_app/repositoreis/authrepo.dart';
import 'package:redwood_app/repositoreis/project_repository.dart';
import 'package:redwood_app/services/request_body.dart';


part 'project_detail_event.dart';

part 'project_detail_state.dart';

class ProjectDetailBloc extends Bloc<ProjectDetailEvent, ProjectDetailState> {
  AuthRepo authRepo;
  ProjectRepository projectRepository;
  Dio? dio;

  ProjectDetailBloc({
    required this.authRepo,
    required this.projectRepository,
    this.dio,
  }) : super(ProjectDetailInitial()) {
    on<GetReportTypeEvent>((event, emit) async {
      await _getReportTypeEvent(event, emit);
    });
    on<GetProjectListEvent>((event, emit) async {
      await _getProjectListEvent(event, emit);
    });
    on<GetProjectDetailsEvent>((event, emit) async {
      await _getProjectDetailsEvent(event, emit);
    });
    on<GetProjectInfoEvent>((event, emit) async {
      await _getProjectInfoEvent(event, emit);
    });
  }

  _getReportTypeEvent(GetReportTypeEvent event, Emitter<ProjectDetailState> emit) async {
    try {
      ReportTypeModel? reportType = await authRepo.reportType(event.context);
      if (reportType!.success!) {
        final List<ReportType>? reportTypeList = reportType.data?.reportType;
        emit(const GetReportTypeState().copyWith(reportName: reportTypeList));
      } else {
        debugPrint("error");
      }
    } catch (e) {
      // checkStatus(event.context);
      debugPrint(e.toString());
    }
  }

  _getProjectListEvent(GetProjectListEvent event, Emitter<ProjectDetailState> emit) async {
    try {
      Map req = RequestBody.projectList(search: event.search);
      ProjectsListModel? projectListModal = await projectRepository.getProjectList(req, event.context);
      if (projectListModal != null && projectListModal.success != null) {
        final ProjectsListModel projectList = projectListModal;
        emit(GetProjectListState(projectList: projectList));
      } else {
        debugPrint("error");
      }
    } catch (e) {

      debugPrint(e.toString());
    }
  }

  _getProjectDetailsEvent(GetProjectDetailsEvent event, Emitter<ProjectDetailState> emit) async {
    try {
      Map req = RequestBody.projectDetails(projectId: event.projectId, search: event.search);
      ProjectDetailsModal? projectDetailsModal = await projectRepository.getProjectDetailsList(req, event.context);
      if (projectDetailsModal != null && projectDetailsModal.success != null) {
        final ProjectDetailsModal projectDetails = projectDetailsModal;
        emit(GetProjectDetailsState(projectDetails: projectDetails));
      } else {
        debugPrint("error");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _getProjectInfoEvent(GetProjectInfoEvent event, Emitter<ProjectDetailState> emit) async {
    try {
      Map req = RequestBody.projectInfo(projectId: event.projectId);
      ProjectInfoModal? projectDetailsModal = await projectRepository.getProjectInfo(req, event.context);
      if (projectDetailsModal != null && projectDetailsModal.success != null) {
        final ProjectInfoModal projectDetails = projectDetailsModal;
        emit(GetProjectInfoState(projectDetails: projectDetails));
      } else {
        debugPrint("error");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
