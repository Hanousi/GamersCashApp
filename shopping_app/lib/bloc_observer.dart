import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:fsearch/fsearch.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print("=======> onEvent: $event");
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print("=======> onTransition: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print("=======> onTransition: $stackTrace");
    super.onError(bloc, error, stackTrace);
  }


}
