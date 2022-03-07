import 'package:formz/formz.dart';

enum PasswordConfirmationValidationError { invalid }

class PasswordConfirmation extends FormzInput<String?, PasswordConfirmationValidationError?> {
  const PasswordConfirmation.pure()
      : password = null,
        super.pure('');
  const PasswordConfirmation.dirty(String? value, {this.password}) : super.dirty(value);

  final String? password;

  @override
  PasswordConfirmationValidationError? validator(String? value) =>
      value != null && value.isNotEmpty && value == password ? null : PasswordConfirmationValidationError.invalid;
}
