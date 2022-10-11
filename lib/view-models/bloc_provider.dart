import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/injection_containers.dart' as di;
import 'package:redwood_app/view-models/projectDetailBloc/project_detail_bloc.dart';
import 'package:redwood_app/view-models/siteSurveyReportBloc/site_survey_report_bloc.dart';

import 'loginbloc/login_bloc.dart';

class MyBlocProvider extends StatelessWidget {
  final Widget child;

  const MyBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => di.serviceLocator()),
        BlocProvider<ProjectDetailBloc>(create: (context) => di.serviceLocator()),
        BlocProvider<SiteSurveyReportBloc>(create: (context) => di.serviceLocator()),
      ],
      child: child,
    );
  }
}
