part of 'ResetCubit.dart';

class ResetState extends Equatable {


  final FormzStatus status;
  final Password password;
  final Password confirmPassword;
  final Email email;
  final Map<String, List<String>>? formErrors;

  const ResetState({
    this.status =  FormzStatus.pure,
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
    this.email = const Email.pure(),
    this.formErrors
  });

  @override
  List<Object?> get props => [status,password,confirmPassword,formErrors,email];

  ResetState copyWith({ Password? password, Password? confirmPassword,Email? email, FormzStatus? status, Map<String, List<String>>?formErrors}) => ResetState(password: password?? this.password,email: email ?? this.email, confirmPassword: confirmPassword?? this.confirmPassword, formErrors: formErrors,status:  status ?? this.status);
}
