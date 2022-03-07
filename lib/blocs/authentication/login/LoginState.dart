import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/inputs/authentication/Password.dart';
import 'package:giraffe_spotter/inputs/authentication/Email.dart';
import 'package:giraffe_spotter/models/User.dart';

class LoginState extends Equatable {
  const LoginState({
        this.email = const Email.pure(),
        this.password = const Password.pure(),
        this.status = FormzStatus.pure,
        this.user = User.empty,
        this.formErrors
      });

  final Email email;
  final Password password;
  final FormzStatus status;
  final User user;
  final Map<String, List<String>>? formErrors;


  @override
  List<Object?> get props => [email, password,formErrors, status, user];

  LoginState copyWith({Email? email, Password? password, FormzStatus? status, User? user, Map<String, List<String>>?formErrors}) => LoginState(
      email: email ?? this.email, formErrors: formErrors, password: password ?? this.password, status: status ?? this.status, user: user ?? this.user);

}
