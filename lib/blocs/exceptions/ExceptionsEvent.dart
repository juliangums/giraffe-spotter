import 'package:equatable/equatable.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';

class ExceptionsEvent extends Equatable {
  const ExceptionsEvent();

  @override
  List<Object?> get props => [];
}

class OnException extends ExceptionsEvent {
  final NetworkExceptions error;

  const OnException(this.error);

  @override
  List<Object?> get props => [error];
}
