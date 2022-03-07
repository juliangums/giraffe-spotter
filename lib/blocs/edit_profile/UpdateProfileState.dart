import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/inputs/authentication/Email.dart';
import 'package:giraffe_spotter/inputs/authentication/Name.dart';
import 'package:giraffe_spotter/models/User.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';

class UpdateProfileState extends Equatable {
  UpdateProfileState({
    this.email = const Email.pure(),
    this.fullName = const Name.pure(),
    this.status = FormzStatus.pure,
    this.user = User.empty,
    this.show = false,
    this.image = false,
    this.error,
    this.errors,
  });
  final Email email;
  final bool? show,image;
  final Name fullName;
  final FormzStatus status;
  final User user;
  final NetworkExceptions? error;
  final Map<String, List<String>>? errors;

  @override
  List<Object?> get props => [email, show,image, fullName, status, user, errors];
  UpdateProfileState copyWith({
    Name? fullName,
    Email? email,
    bool? image,
    FormzStatus? status,
    User? user,
    bool? show,
    NetworkExceptions? error,
    Map<String, List<String>>? errors,
  }) =>
      UpdateProfileState(
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        status: status ?? this.status,
        user: user ?? this.user,
        error: error,
        image: image,
        show: show,
        errors: errors,
      );
}
