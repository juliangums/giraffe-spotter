import 'package:formz/formz.dart';

enum AgeValidationError { invalid }

class Age extends FormzInput<String, AgeValidationError> {
  const Age.pure() : super.pure('');
  const Age.dirty([String value = '']) : super.dirty(value);

  @override
  validator(String value) => value.isNotEmpty ? null : AgeValidationError.invalid;
}
