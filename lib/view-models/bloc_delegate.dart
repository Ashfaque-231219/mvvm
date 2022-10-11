import 'package:flutter_bloc/flutter_bloc.dart';

import '../helper/utils/utils.dart';

/// Custom [BlocObserver] which observes all bloc and cubit instances.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    printLog('Event==> $event');
  }
/* 
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    printLog('Change==> $change');
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    printLog('Create==> $bloc');
  } */

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    printLog('Transition==> $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    printError('Error==> $error');
    super.onError(bloc, error, stackTrace);
  }
}
