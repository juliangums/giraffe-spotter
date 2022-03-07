import 'package:equatable/equatable.dart';
import 'package:giraffe_spotter/models/User.dart';

enum AuthenticationStatus { authenticated, verified, completed, unauthenticated, unknown, no_internet }

class AuthenticationState extends Equatable {
  const AuthenticationState._({this.status = AuthenticationStatus.unknown, this.user = User.empty});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user) : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.verified(User user) : this._(status: AuthenticationStatus.verified, user: user);

  const AuthenticationState.completed(User user) : this._(status: AuthenticationStatus.completed, user: user);

  const AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.noInternet() : this._(status: AuthenticationStatus.no_internet);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
