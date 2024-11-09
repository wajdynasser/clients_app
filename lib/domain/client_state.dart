part of 'client_cubit.dart';

@immutable
abstract class ClientState {}

class GetInitial extends ClientState {}

/// Get
class GetClientInitial extends ClientState {}

class GetClientLoaded extends ClientState {
  final List<Client> clients;

  GetClientLoaded({required this.clients});
}

class GetClientFailed extends ClientState {}

/// Update
class UpdateClientInitial extends ClientState {}

class UpdateClientLoaded extends ClientState {}

class UpdateClientFailed extends ClientState {}

/// Delete
class DeleteClientInitial extends ClientState {}

class DeleteClientLoaded extends ClientState {}

class DeleteClientFailed extends ClientState {}

/// Create
class CreateClientInitial extends ClientState {}

class CreateClientLoaded extends ClientState {}

class CreateClientFailed extends ClientState {}

/// Expiry Notification for Tomorrow
class ClientExpiringSoonState extends ClientState {
  final List<Client> expiringClients;

  ClientExpiringSoonState(this.expiringClients);
}

/// Expiry Notification for Today
class ClientExpiringTodayState extends ClientState {
  final List<Client> expiringTodayClients;

  ClientExpiringTodayState(this.expiringTodayClients);
}

class SubscriptionDurationUpdated extends ClientState {
  final int remainingDays;

  SubscriptionDurationUpdated(this.remainingDays);
}
