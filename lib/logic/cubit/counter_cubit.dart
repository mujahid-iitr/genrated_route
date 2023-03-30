import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_concepts/constants/enums.dart';
import 'package:meta/meta.dart';

import 'internet_cubit.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  StreamSubscription internetCubitStreamSubscription;

  CounterCubit({@required this.internetCubit})
      : super(CounterState(counterValue: 0)) {
    monitorInternetCubit();
  }

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncremented: true));

  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1, wasIncremented: false));

  @override
  Future<void> close() {
    internetCubitStreamSubscription.cancel();
    return super.close();
  }

  void monitorInternetCubit() {
    monitorInternetConnection();
  }

  void monitorInternetConnection() {
    internetCubitStreamSubscription = internetCubit.listen((internetState) {
      if (internetState is InternetConnect &&
          internetState.connectionType == ConnectionType.Wifi) {
        increment();
      } else if (internetState is InternetConnect &&
          internetState.connectionType == ConnectionType.Mobile) {
        decrement();
      }
    });
  }
}
