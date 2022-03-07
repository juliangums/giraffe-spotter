import 'package:formz/formz.dart';

enum LocationValidationError { invalid }

class Location extends FormzInput<String, LocationValidationError> {
  const Location.pure() : super.pure('');
  const Location.dirty([String value = '']) : super.dirty(value);

  @override
  validator(String value) => value.isNotEmpty ? null : LocationValidationError.invalid;
}
