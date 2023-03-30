part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnect extends InternetState {
  final ConnectionType connectionType;

  InternetConnect({@required this.connectionType});
}

class InternetDisconnect extends InternetState {}
