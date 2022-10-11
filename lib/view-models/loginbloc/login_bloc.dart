import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redwood_app/databases/database.dart';
import 'package:redwood_app/databases/report_type_dao/report_type_database.dart';
import 'package:redwood_app/databases/site_survey_reports_dao/survey_reports.dart';
import 'package:redwood_app/helper/utils/shared_pref.dart';
import 'package:redwood_app/models/change_pass_model/change_pass_model.dart';
import 'package:redwood_app/models/edit_profile_model.dart';
import 'package:redwood_app/models/forgot_pass_modal.dart';
import 'package:redwood_app/models/log_out_model/log_out_modal.dart';
import 'package:redwood_app/models/otp_verify_model.dart';
import 'package:redwood_app/models/user_details.dart';
import 'package:redwood_app/view-models/event_status.dart';
import 'package:redwood_app/view/auth/login_screen.dart';
import 'package:redwood_app/view/shared_widget/Internet_widget.dart';

import '../../databases/punch_list_dao/punch_list_database.dart';
import '../../databases/report_dao/report_database.dart';
import '../../helper/constants/constants.dart';
import '../../models/login/get_report_type.dart';
import '../../models/login/login_modal.dart';
import '../../repositoreis/authrepo.dart';
import '../../route_generator.dart';
import 'login_state.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepo authRepo;
  Dio? dio;

  LoginBloc({required this.authRepo, this.dio, AppDatabase? database}) : super(LoginState()) {
    on<GetLoginEvent>((event, emit) async {
      await _getLoginEvent(event, emit);
    });
    on<ForgotPassEvent>((event, emit) async {
      await _forgotpassEvent(event, emit);
    });
    on<OtpVerifyEvent>((event, emit) async {
      await _otpVerifyEvent(event, emit);
    });
    on<ResetPasswordEvent>((event, emit) async {
      await _ResetPasswordEvent(event, emit);
    });
    on<logoutEvent>((event, emit) async {
      await _logoutEvent(event, emit);
    });
    on<ChangePassEvent>((event, emit) async {
      await _changePassEvent(event, emit);
    });
    on<UpdateProfileEvent>((event, emit) async {
      await _UpdateProfileEvent(event, emit);
    });
    on<GetProfileEvent>((event, emit) async {
      await _GetProfileEvent(event, emit);
    });
    on<ChangeInfoEvent>((event, emit) async {
      await _ChangeInfoEvent(event, emit);
    });
    on<AddSiteSurveyFormEvent>((event, emit) async {
      await _addSiteSurveyFormEvent(event, emit, database);
    });

    on<AddReportEvent>((event, emit) async {
      await _addReportEvent(event, emit, database);
    });

    on<ReportTypeEvent>((event, emit) async {
      await _reportTypeEvent(event, emit, database);
    });

    on<GetReportTypeEvent>((event, emit) async {
      await _getReportTypeEvent(event, emit, database);
    });

    on<UpdateLayoutPlanImageEvent>((event, emit) async {
      await _updateLayoutPlanImageEvent(event, emit, database);
    });

    on<GetSiteSurveyDetailsEvent>((event, emit) async {
      await _getSiteSurveyDetailsEvent(event, emit, database);
    });

    on<GetPunchListByIdEvent>((event, emit) async {
      await _getPunchListByIdEvent(event, emit, database);
    });

    // on<InsertProjectDetails>((event, emit) async
    // {await _insertProjectDetails(event, emit, database);});
    on<InsertPunchList>((event, emit) async {
      await _insertPunchList(event, emit, database);
    });
    on<UpdatePunchList>((event, emit) async {
      await _updatePunchList(event, emit, database);
    });
    on<GetPunchList>((event, emit) async {
      await _getPunchList(event, emit, database);
    });
    // on<GetReportByIdEvent>((event, emit) async {
    //   await _getReportByIdEvent(event, emit, database);
    // });
  }

  _getLoginEvent(GetLoginEvent event, Emitter<LoginState> emitter) async {
    var isConnected = await CheckInternet.checkInternetConnectivity();
    if (isConnected) {
      try {
        emitter(state.copyWith(stateStatus: StateLoading()));
        Map<String, dynamic> req = {};
        req['email'] = event.email;
        req['password'] = event.password;
        LoginModal loginModel = await authRepo.loginService(req, event.context!);

        print(loginModel.message.toString());
        if (loginModel.success) {
          emitter(state.copyWith(stateStatus: StateLoaded(successMessage: loginModel.message.toString())));
          SharedPref.setBool(key: Constants.rememberMe, data: event.remember!);

          var token = loginModel.token;
          var tokens = await SharedPref.setString(key: "token", data: token.toString());
          Navigator.pushReplacementNamed(event.context!, RoutesConst.dashboard);
        } else {
          emitter(state.copyWith(stateStatus: StateFailed(errorMessage: loginModel.message.toString())));
        }
      } catch (e) {
        emitter(state.copyWith(stateStatus: StateFailed(errorMessage: 'Falied')));

        print(e.toString());
      }
    } else {
      emitter(state.copyWith(stateStatus: StateFailed(errorMessage: 'Falied')));
      CheckInternet.showNetworkDialog(event.context);
    }
  }

  _forgotpassEvent(ForgotPassEvent event, Emitter<LoginState> emitter) async {
    emitter(state.copyWith(stateStatus: StateLoading()));
    try {
      Map<String, dynamic> req = {};
      req['email'] = event.email;
      SharedPref.setString(key: 'email', data: event.email.toString());
      ForgotPassModal forgotPassModal = await authRepo.ForgotService(req);

      if (forgotPassModal.status == true) {
        print("forget Pasworrd=====${forgotPassModal.message}");
        stateStatus:
        emitter(state.copyWith(stateStatus: StateLoaded(successMessage: forgotPassModal.message.toString())));

        Navigator.pushNamed(event.context!, RoutesConst.otpVerification).then((value) {});
      } else {
        emitter(state.copyWith(stateStatus: StateFailed(errorMessage: 'Falied')));
      }
    } catch (e) {
      emitter(state.copyWith(stateStatus: StateFailed(errorMessage: 'Falied')));
      print(e.toString());
    }
  }

  _otpVerifyEvent(OtpVerifyEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      Map<String, dynamic> req = {};
      req['email'] = event.email;
      req['otp'] = event.otp;
      OTPVerifyMODEL otpVerifyMODEL = await authRepo.verifyOtpService(req);
      if (otpVerifyMODEL.status == true) {
        emit(state.copyWith(stateStatus: StateLoaded(successMessage: otpVerifyMODEL.message.toString())));
        Navigator.pushNamed(event.context!, RoutesConst.forgotPassSave);
      } else {
        emit(state.copyWith(stateStatus: StateFailed(errorMessage: 'Falied')));
      }
    } catch (e) {
      emit(state.copyWith(stateStatus: StateFailed(errorMessage: 'Falied')));
    }
  }

  _ResetPasswordEvent(ResetPasswordEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      Map<String, dynamic> req = {};
      req['email'] = event.email;
      req['password'] = event.password;
      req['password_confirmation'] = event.confirmPassword;
      OTPVerifyMODEL otpVerifyMODEL = await authRepo.resetPasswordService(req);
      if (otpVerifyMODEL.status == true) {
        emit(state.copyWith(stateStatus: StateLoaded(successMessage: otpVerifyMODEL.message.toString())));
        Navigator.push(event.context!, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(stateStatus: StateFailed(errorMessage: 'Falied')));
    }
  }

  _logoutEvent(logoutEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      LogoutModal logoutModal = await authRepo.logoutService();
      if (logoutModal.success == true) {
        emit(state.copyWith(stateStatus: StateLoaded(successMessage: logoutModal.message.toString())));

        await SharedPref.setString(key: 'token', data: '');
        await SharedPref.setBool(key: Constants.rememberMe, data: false);

        Navigator.push(event.context!, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        emit(state.copyWith(stateStatus: StateFailed(errorMessage: 'Falied')));
      }
    } catch (e) {
      emit(state.copyWith(stateStatus: StateFailed(errorMessage: 'Falied')));
      print(e.toString());
    }
  }

  _changePassEvent(ChangePassEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      Map<String, dynamic> req = {'old_password': event.oldPassword, 'password': event.newPassword};
      ChangePassModel changePassModel = await authRepo.changePassServices(req, event.context!);
      if (changePassModel.status == true) {
        emit(state.copyWith(stateStatus: StateLoaded(successMessage: changePassModel.message.toString())));
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(event.context!);

          // Do something
        });
      }
    } catch (e) {
      emit(state.copyWith(stateStatus: StateFailed(errorMessage: 'Falied')));
      print(e.toString());
    }
  }

  _UpdateProfileEvent(UpdateProfileEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      if (event.image == null) {
        Map<String, dynamic> req = {
          'name': event.name,
        };
        EditProfileModel editProfileModel = await authRepo.editProfileServices(req, event.context!);
        if (editProfileModel.success == true) {
          emit(state.copyWith(stateStatus: StateLoaded(successMessage: editProfileModel.message.toString())));
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pop(event.context!);
            // Do something
          });
        }
      } else {
        emit(state.copyWith(stateStatus: StateLoading()));
        Map<String, dynamic> req = {'name': event.name, 'image': event.image};
        EditProfileModel editProfileModel = await authRepo.editProfileServices(req, event.context!);
        if (editProfileModel.success == true) {
          emit(state.copyWith(stateStatus: StateLoaded(successMessage: editProfileModel.message.toString())));
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pop(event.context!);

            // Do something
          });
        } else {
          emit(state.copyWith(stateStatus: StateFailed(errorMessage: 'Falied')));
        }
      }
    } catch (e) {
      emit(state.copyWith(stateStatus: StateFailed(errorMessage: 'Falied')));
      var statusCode = await SharedPref.getInt(key: 'error-code');
      print("THe status code is ========>>>>>>>>>>>>>>>>>>>>>>> $statusCode");
      if (statusCode == 401) {
        Navigator.pushNamedAndRemoveUntil(event.context!, RoutesConst.login, (route) => false);
      }
      print(e.toString());
    }
  }

  _GetProfileEvent(GetProfileEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      UserDetail userDetail = await authRepo.getProfileServices(event.context!);
      if (userDetail.success == true) {
        emit(state.copyWith(stateStatus: StateLoaded(successMessage: userDetail.message.toString())));
        emit(state.copyWith(
            name: userDetail.data?.name,
            date: userDetail.data?.createdAt,
            email: userDetail.data?.email,
            image: userDetail.data?.photo,
            userDetail: userDetail));
      }
    } catch (e) {
      emit(state.copyWith(stateStatus: StateFailed(errorMessage: 'Falied')));
      var statusCode = await SharedPref.getInt(key: 'error-code');
      print("THe status code is ========>>>>>>>>>>>>>>>>>>>>>>> $statusCode");
      if (statusCode == 401) {
        Navigator.pushNamedAndRemoveUntil(event.context!, RoutesConst.login, (route) => false);
      }

      print(e.toString());
    }
  }

  _ChangeInfoEvent(ChangeInfoEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(name: event.name, image: event.image));
  }

  _addSiteSurveyFormEvent(AddSiteSurveyFormEvent event, Emitter<LoginState> emit, AppDatabase? database) async {
    try {
      int reportTypeId = await SharedPref.getInt(key: "reportTypeId");
      int? reportId = await database?.siteSurveyReportsDao.insertUser(SiteSurveyReports(
          reportId: reportTypeId,
          length: event.length,
          width: event.width,
          onloadingLocation: event.onloadingLocation,
          offloadingLocation: event.offloadingLocation,
          createdAt: DateTime.now().toString(),
          updatedAt: DateTime.now().toString()));

      await SharedPref.setInt(key: "reportId", data: reportId ?? 0);
    } catch (e) {
      print(e.toString());
    }
  }

  _reportTypeEvent(ReportTypeEvent event, Emitter<LoginState> emit, AppDatabase? database) async {
    try {
      ReportTypeModel? reportType = await authRepo.reportType(event.context!);

      if (reportType!.success!) {
        List<int?>? report_id_list = await database?.reportTypeDao.getAllReportsId();
        List<ReportType> reportTypeList = reportType.data?.reportType ?? [];
        int reportTypeId = await SharedPref.getInt(key: "report");
        try {
          for (var value in reportTypeList) {
            if (report_id_list != null && report_id_list.contains(value.id)) {
              await database?.reportTypeDao.updateReportId(reportTypeId, value.id ?? 0);
            } else {
              int? id = await database?.reportTypeDao.insertReportType(GetReportType(
                reportId: value.id,
                reportName: value.name,
                createdAt: value.createdAt,
                updatedAt: value.updatedAt,
              ));
              await SharedPref.setInt(key: "report", data: id ?? 0);
            }
          }

          emit(state.copyWith(reportName: reportType.data?.reportType));
        } catch (e) {
          print(e.toString());
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // _insertProjectDetails(InsertProjectDetails event, Emitter<LoginState> emit, AppDatabase? database)async{
  //   try{
  //
  //     DashboardModel dashboardModel = await authRepo.getProjectDetail(event.context!);
  //     if(dashboardModel.success!) {
  //
  //       List<ProjectCategory>? projectCategories = await dashboardModel.data?.projectDetails?[0].projectCategory;
  //
  //       int? projectCategoryId = await database?.projectCategoryDao.insertCategory(ProjectCategories(
  //         name: projectCategories?[0].name,
  //         color: projectCategories?[0].color,
  //         createdAt: DateTime.now().toString(),
  //         updatedAt: DateTime.now().toString(),
  //       ));
  //
  //       int? projectId = await database?.projectDetailDao.insertProject(
  //           ProjectDetail(
  //             projectName: dashboardModel.data?.projectDetails?[0].projectName,
  //             address: dashboardModel.data?.projectDetails?[0].address,
  //             logo: dashboardModel.data?.projectDetails?[0].logo,
  //             createdAt: DateTime.now().toString(),
  //             updatedAt: DateTime.now().toString(),
  //           ));
  //
  //       List<ProjectDetail?>? projectDetail = await database?.projectDetailDao.getAllProject();
  //
  //       emit(state.copyWith(projectDetailList: projectDetail));
  //     }
  //   }catch(e){
  //     print(e.toString());
  //   }
  // }

  _getReportTypeEvent(GetReportTypeEvent event, Emitter<LoginState> emit, AppDatabase? database) async {
    try {
      List<Report>? allReports = await database?.reportDao.getAllReports();
      print("allreports======$allReports");
      emit(state.copyWith(getAllReportType: allReports));
    } catch (e) {
      print(e.toString());
    }
  }

  _updateLayoutPlanImageEvent(UpdateLayoutPlanImageEvent event, Emitter<LoginState> emit, AppDatabase? database) async {
    try {
      int reportId = await SharedPref.getInt(key: "reportId");

      await database?.siteSurveyReportsDao.updateLayoutPlanImage(
        reportId,
        event.image ?? "",
        event.description ?? "",
        DateTime.now().toString(),
        DateTime.now().toString(),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  _upload360Image(Upload360Image event, Emitter<LoginState> emit, AppDatabase? database) {
    try {} catch (e) {
      print(e.toString());
    }
  }

  _addReportEvent(AddReportEvent event, Emitter<LoginState> emit, AppDatabase? database) async {
    try {
      int? reportId = await database?.reportDao.insertReport(Report(
        reportName: "Site Survey Report",
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
      ));
      List<Report>? allReports = await database?.reportDao.getAllReports();
      print("reportId ====$reportId");
    } catch (e) {
      print(e.toString());
    }
  }

  // _getReportByIdEvent(GetReportByIdEvent event, Emitter<LoginState> emit, AppDatabase? database) async {
  //   try {
  //     SiteSurveyReports? reportsDetails = await database?.siteSurveyReportsDao.getReportById(event.id ?? 0);
  //     print("reportdetails ====$reportsDetails");
  //
  //     emit(state.copyWith(reportDetails: reportsDetails));
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  _getSiteSurveyDetailsEvent(GetSiteSurveyDetailsEvent event, Emitter<LoginState> emit, AppDatabase? database) async {
    try {
      List<SiteSurveyReports?> reportsDetails = await database!.siteSurveyReportsDao.getAllSiteSurveyReport();
      print("SiteSurveryReportsdetails ====$reportsDetails");

      emit(state.copyWith(SitesurveyreportDetails: reportsDetails));
    } catch (e) {
      print(e.toString());
    }
  }

  _insertPunchList(InsertPunchList event, Emitter<LoginState> emit, AppDatabase? database) async {
    try {
      int? punchListId = await database?.punchListDao.insertPunchList(PunchList(
          beforeDescription: event.beforeDescription,
          beforeImage: event.beforeImage,
          expectedCompletionDate: event.expectedCompletionDate,
          referenceId: 001,
          status: "Open"));

      SharedPref.setInt(key: "punchListId", data: punchListId!);
    } catch (e) {
      print(e.toString());
    }
  }

  _updatePunchList(UpdatePunchList event, Emitter<LoginState> emit, AppDatabase? database) async {
    try {
      int? punchListId = await SharedPref.getInt(key: "punchListId");
      PunchList? punchList = await database?.punchListDao.resolvePunchList(punchListId, event.afterImage ?? "", event.afterDescription ?? "",
          event.actualCompletionDate ?? "", DateTime.now().toString(), DateTime.now().toString(), "Close");
    } catch (e) {
      print(e.toString());
    }
  }

  _getPunchList(GetPunchList event, Emitter<LoginState> emit, AppDatabase? database) async {
    try {
      List<PunchList>? punchListDetails = await database?.punchListDao.getAllIssues();
      emit(state.copyWith(punchListDetails: punchListDetails));
      List<PunchList>? openPunchList = [];
      List<PunchList>? closePunchList = [];
      if (punchListDetails != null) {
        for (var list in punchListDetails) {
          if (list.status.toString().toLowerCase() == "Open".toString().toLowerCase()) {
            openPunchList.add(list);
            print("opnePunchList=====$openPunchList");
            emit(state.copyWith(openPunchList: openPunchList));
          } else {
            closePunchList.add(list);
            print("closePunchList=====$closePunchList");
            emit(state.copyWith(closePunchList: closePunchList));
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _getPunchListByIdEvent(GetPunchListByIdEvent event, Emitter<LoginState> emit, AppDatabase? database) async {
    try {
      PunchList? punchListDetails = await database?.punchListDao.getPunchListById(event.id ?? 0);

      emit(state.copyWith(punchList: punchListDetails));
    } catch (e) {
      print(e.toString());
    }
  }
}
