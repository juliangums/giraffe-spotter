import 'package:formz/formz.dart';

enum SpeciesValidationError { invalid }

class Species extends FormzInput<String, SpeciesValidationError> {
  const Species.pure() : super.pure('');
  const Species.dirty([String value = '']) : super.dirty(value);

  @override
  validator(String value) => value.isNotEmpty ? null : SpeciesValidationError.invalid;
}
