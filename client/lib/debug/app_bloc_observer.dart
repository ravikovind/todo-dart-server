import 'package:flutter_bloc/flutter_bloc.dart';

/// [AppBlocObserver] is a [BlocObserver] that logs all events and states.
/// It is used to debug the application.
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    // ('\x1B[32mOn Change(${bloc.runtimeType}, $change)\x1B[0m');
    return super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    // print('\x1B[31mOn Error(${bloc.runtimeType}, $error)\x1B[0m');
    return super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    // print('\x1B[32mOn Event(${bloc.runtimeType}, $event)\x1B[0m');
    return super.onEvent(bloc, event);
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    // print('\x1B[32mOn Transition(${bloc.runtimeType}, $transition)\x1B[0m');
    return super.onTransition(bloc, transition);
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    // print('\x1B[32mOn Create(${bloc.runtimeType})\x1B[0m');
    return super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    // print('\x1B[32mOn Close(${bloc.runtimeType})\x1B[0m');
    return super.onClose(bloc);
  }
}
