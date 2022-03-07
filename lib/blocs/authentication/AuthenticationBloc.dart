import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/models/User.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';
import 'package:giraffe_spotter/repositories/AuthenticationRepository.dart';
import 'package:pedantic/pedantic.dart';

import 'AuthenticationEvent.dart';
import 'AuthenticationState.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthenticationRepository authRepository})
      : _authenticationRepository = authRepository,
        super(const AuthenticationState.unknown());

  final AuthenticationRepository _authenticationRepository;
  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    }
    else if (event is AuthenticationUserChanged) {
      yield* _mapAuthenticationUserChangedToState(event);
    }
    else if (event is AuthenticationLogoutRequested) {
      unawaited(_authenticationRepository.logout());
      yield const AuthenticationState.unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = _authenticationRepository.isSignedIn;
    if (isSignedIn) {
      final result = await _authenticationRepository.user;
      yield* result.when(success: (User? user) async* {
        add(AuthenticationUserChanged(user!));
      }, failure: (NetworkExceptions? error) async* {
        yield* error!.maybeWhen(
            unauthenticatedRequest: () async* {
              yield const AuthenticationState.unauthenticated();
            },
            noInternetConnection: () async* {
              yield const AuthenticationState.noInternet();
            },
            orElse: () async* {
            });
      });
    } else {
      yield const AuthenticationState.unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationUserChangedToState(AuthenticationUserChanged event) async* {
    if (event.user != User.empty) {
      yield AuthenticationState.authenticated(event.user);
    } else {
      yield const AuthenticationState.unauthenticated();
    }
  }
}
