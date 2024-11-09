import 'package:bloc/bloc.dart';
import 'package:clients/data/model/clients_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../data/repository/repository.dart';

part 'client_state.dart';

class ClientCubit extends Cubit<ClientState> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final Repository repository;

  ClientCubit(this.repository, this.flutterLocalNotificationsPlugin)
      : super(GetInitial());

  List<Client> allClients = [];
  List<Client> endSoon = [];

  Future<void> getAllClients() async {
    emit(GetClientInitial());
    try {
      allClients = await repository.getAllClients();
      endSoon =
          allClients.where((item) => item.subscriptionDuration == 1).toList();
      emit(GetClientLoaded(clients: allClients));
    } catch (e) {
      print('Error fetching clients: ${e.toString()}');
      emit(GetClientFailed());
    }
  }

  Future<void> insertClient({required Client client}) async {
    emit(CreateClientInitial());
    try {
      await repository.insertClient(client);
      emit(CreateClientLoaded());
      await getAllClients(); // Refresh list
    } catch (e) {
      print('Error inserting client: ${e.toString()}');
      emit(CreateClientFailed());
    }
  }

  Future<void> updateClient({required Client client}) async {
    emit(UpdateClientInitial());
    try {
      await repository.updateClient(client);
      emit(UpdateClientLoaded());
      await getAllClients(); // Refresh list
    } catch (e) {
      print('Error updating client: ${e.toString()}');
      emit(UpdateClientFailed());
    }
  }

  Future<void> deleteClient({required int id}) async {
    emit(DeleteClientInitial());
    try {
      await repository.deleteById(id);
      emit(DeleteClientLoaded());
      await getAllClients(); // Refresh list
    } catch (e) {
      print('Error deleting client: ${e.toString()}');
      emit(DeleteClientFailed());
    }
  }

  void checkSubscriptionExpiry() {
    List<Client> expiringTodayClients = [];

    for (final client in allClients) {
      final remainingDays = DateTime.parse(client.subscriptionEnd)
          .difference(DateTime.now())
          .inDays;

      if (remainingDays == 1) {
        _showExpiryNotification(client);
        expiringTodayClients.add(client); // Add to list if expiring tomorrow
      }
      if (remainingDays == 0) {
        expiringTodayClients.add(client); // Add to list if expiring today
      }
    }

    if (expiringTodayClients.isNotEmpty) {
      emit(ClientExpiringSoonState(
          expiringTodayClients)); // Emit the list of expiring clients
    }
  }

  Future<void> _showExpiryNotification(Client client) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'subscription_channel',
      'Subscription Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'أشعار إنتهاء الإشتراك',
      ' الإشتراك بالنسبة لـ ${client.clientName} سوف ينتهي غداً ',
      notificationDetails,
    );
  }

  Future<void> calculateAndSaveSubscriptionDuration(Client client) async {
    DateTime startDate =
        DateFormat('yyyy-MM-dd').parse(client.subscriptionDate);
    DateTime endDate = DateFormat('yyyy-MM-dd').parse(client.subscriptionEnd);
    DateTime currentDate = DateTime.now();

    int remainingDays = endDate.difference(currentDate).inDays;
    remainingDays = remainingDays < 0 ? 0 : remainingDays;

    Client updatedClient = client.copyWith(subscriptionDuration: remainingDays);
    try {
      await repository.updateClient(updatedClient);
      emit(SubscriptionDurationUpdated(remainingDays));
    } catch (e) {
      print('Error updating subscription duration: ${e.toString()}');
    }
  }

  // Fetch clients with subscriptions expiring today and emit state
  void getExpiringTodayClients() {
    final todayExpiringClients = allClients.where((client) {
      final endDate = DateTime.parse(client.subscriptionEnd);
      return endDate.difference(DateTime.now()).inDays == 0;
    }).toList();
    emit(ClientExpiringTodayState(todayExpiringClients));
  }
}
