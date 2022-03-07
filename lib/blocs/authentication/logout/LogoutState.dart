part of 'LogoutCubit.dart';


class LogoutState extends Equatable {

  final FormzStatus formzStatus;

  const LogoutState ({this.formzStatus =  FormzStatus.pure});



  @override
  List<Object?> get props => [formzStatus];

  LogoutState copyWith({FormzStatus? formzStatus}) => LogoutState(formzStatus: formzStatus ?? this.formzStatus);
}
