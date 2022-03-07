import 'package:formz/formz.dart';

enum GenderValidationError { invalid }

class Gender extends FormzInput<String, GenderValidationError> {
  const Gender.pure() : super.pure('');
  const Gender.dirty([String value = '']) : super.dirty(value);

  @override
  validator(String value) => value.isNotEmpty ? null : GenderValidationError.invalid;
}
