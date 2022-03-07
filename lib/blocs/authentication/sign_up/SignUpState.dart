import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/inputs/authentication/AcceptTerms.dart';
import 'package:giraffe_spotter/inputs/authentication/Email.dart';
import 'package:giraffe_spotter/inputs/authentication/Name.dart';
import 'package:giraffe_spotter/inputs/authentication/Password.dart';
import 'package:giraffe_spotter/models/User.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';

class SignUpState extends Equatable {
  SignUpState({
    this.fullName = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.acceptTerms = const AcceptTerms.pure(),
    this.status = FormzStatus.pure,
    this.user = User.empty,
    this.error,
    this.errors,
  });
  final Email email;
  final Password password;
  final Name fullName;
  final AcceptTerms acceptTerms;
  final FormzStatus status;
  final User user;
  final NetworkExceptions? error;
  final Map<String, List<String>>? errors;
  @override
  List<Object?> get props => [fullName, email, password, acceptTerms, status, user, errors];
  SignUpState copyWith(
          {Name? fullName,
          Email? email,
          Password? password,
          AcceptTerms? acceptTerms,
          FormzStatus? status,
          User? user,
          NetworkExceptions? error,
          Map<String, List<String>>? errors}) =>
      SignUpState(
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        password: password ?? this.password,
        acceptTerms: acceptTerms ?? this.acceptTerms,
        status: status ?? this.status,
        user: user ?? this.user,
        error: error,
        errors: errors,
      );
}
