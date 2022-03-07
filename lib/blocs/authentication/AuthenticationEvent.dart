import 'package:equatable/equatable.dart';
import 'package:giraffe_spotter/models/User.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class AuthenticationStarted extends AuthenticationEvent {
  const AuthenticationStarted();

  @override
  List<Object> get props => [];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class NoConnectivityEvent extends AuthenticationEvent {}
