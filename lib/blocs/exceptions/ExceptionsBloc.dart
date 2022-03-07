import 'package:flutter_bloc/flutter_bloc.dart';

import 'ExceptionsEvent.dart';
import 'ExceptionsState.dart';

class ExceptionsBloc extends Bloc<ExceptionsEvent, ExceptionsState> {
  ExceptionsBloc() : super(ExceptionsState());

  @override
  Stream<ExceptionsState> mapEventToState(ExceptionsEvent event) async* {
    if (event is OnException) {
      yield* event.error.maybeWhen(
          unauthenticatedRequest: () async* {
            yield UnAuthenticatedError();
          },
          orElse: () async* {});
    }
  }
}
