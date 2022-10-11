import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redwood_app/databases/database.dart';
import 'package:redwood_app/injection_containers.dart' as di;
import 'package:redwood_app/route_generator.dart';
import 'package:redwood_app/view-models/bloc_delegate.dart';
import 'package:redwood_app/view-models/bloc_provider.dart';
import 'package:redwood_app/view/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // For Disabling the Landscape Mode in flutter

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final database = await $FloorAppDatabase.databaseBuilder('redwood_database.db').build();
  print(database);
  await di.init(database);
  BlocOverrides.runZoned(() => runApp(const MyApp()), blocObserver: SimpleBlocObserver());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MyBlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesConst.splash,
        onGenerateRoute: RoutesConst.generateRoute,
        home: SplashPage(),
        // home: SplashPage(),
      ),
    );
  }
}
