import 'CheckConnectionState.dart';

abstract class CheckNetworkConnectionEvent {}

class ListenConnection extends CheckNetworkConnectionEvent {}

class ConnectionChanged extends CheckNetworkConnectionEvent {
  CheckNetworkConnectionState connection;
  ConnectionChanged(this.connection);
}
