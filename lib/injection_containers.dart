import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:redwood_app/databases/database.dart';
import 'package:redwood_app/repositoreis/authrepo.dart';
import 'package:redwood_app/repositoreis/project_repository.dart';
import 'package:redwood_app/repositoreis/report_repository.dart';
import 'package:redwood_app/services/authservice.dart';
import 'package:redwood_app/view-models/loginbloc/login_bloc.dart';
import 'package:redwood_app/view-models/projectDetailBloc/project_detail_bloc.dart';
import 'package:redwood_app/view-models/siteSurveyReportBloc/site_survey_report_bloc.dart';

import 'helper/utils/request_interceptor.dart';
import 'services/project_services.dart';
import 'services/report_services.dart';

final serviceLocator = GetIt.instance;
//start//sl=> service locator

Future<void> init(AppDatabase database) async {
/* ==================================== Features ====================================== */

  //! blocs
  serviceLocator.registerFactory(() => LoginBloc(authRepo: serviceLocator(), database: database));
  serviceLocator.registerFactory(() => ProjectDetailBloc(authRepo: serviceLocator(), projectRepository: serviceLocator()));
  serviceLocator.registerFactory(() => SiteSurveyReportBloc(reportRepository: serviceLocator()));

  //! Services
  serviceLocator.registerLazySingleton<AuthRepo>(() => AuthService(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<ProjectRepository>(() => ProjectServices(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<ReportRepository>(() => ReportServices(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<Dio>(() => DioClient().provideDio());

/* =================================== External ======================================= */
/*   final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton(sharedPreferences);

  sl.registerLazySingleton<SharedPreferenceModule>(
      () => SharedPreferenceModule(pref: sl<SharedPreferences>())); */

  //End
}
