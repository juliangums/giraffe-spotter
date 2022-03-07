part of 'ForgotCubit.dart';

class ForgotState extends Equatable {

  const ForgotState({
    this.email  = const Email.pure(),
    this.status = FormzStatus.pure,
    this.formErrors,
    this.page = false,
    this.link,
  });

  final Email email;
  final bool? page;
  final FormzStatus status;
  final Map<String, List<String>>? formErrors;
  final Uri? link;


  @override
  List<Object?> get props => [email,status,formErrors,link,page];

  ForgotState  copyWith({Email? email,bool? page, FormzStatus? status,Map<String, List<String>>? formErrors, Uri? link})=>
      ForgotState(link: link,email: email?? this.email, page: page, formErrors: formErrors,status: status ?? this.status);
}
