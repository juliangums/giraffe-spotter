import 'package:formz/formz.dart';

enum AcceptTermsValidationError { invalid }

class AcceptTerms extends FormzInput<bool, AcceptTermsValidationError?> {
  const AcceptTerms.pure() : super.pure(false);
  const AcceptTerms.dirty([bool value = false]) : super.dirty(value);

  @override
  AcceptTermsValidationError? validator(bool value) => value ? null : AcceptTermsValidationError.invalid;
}
