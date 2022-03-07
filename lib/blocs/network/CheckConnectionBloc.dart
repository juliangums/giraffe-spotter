import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/network/CheckConnectionEvent.dart';
import 'package:giraffe_spotter/blocs/network/CheckConnectionState.dart';

class CheckNetworkConnectionBloc extends Bloc<CheckNetworkConnectionEvent, CheckNetworkConnectionState> {
  CheckNetworkConnectionBloc() : super(ConnectionInitial());
  StreamSubscription? _streamSubscription;
  bool intialState = false;

  @override
  Stream<CheckNetworkConnectionState> mapEventToState(CheckNetworkConnectionEvent event) async* {
    if (event is ListenConnection) {
      _streamSubscription = DataConnectionChecker().onStatusChange.listen((status) {
        add(ConnectionChanged(
          status == DataConnectionStatus.disconnected ? ConnectionFailure() : ConnectionSuccess(),
        ));
      });
    }
    if (event is ConnectionChanged) yield event.connection;
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  changeBool(bool checker) {
    intialState = true;
    print("this is the bool ::: " + intialState.toString());
    // emit(intialState);
  }
}
