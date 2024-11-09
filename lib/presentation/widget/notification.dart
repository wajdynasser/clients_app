import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/client_cubit.dart';

class ExpiringSubscriptionsScreen extends StatelessWidget {
  const ExpiringSubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expiring Subscriptions'),
        centerTitle: true,
      ),
      body: BlocBuilder<ClientCubit, ClientState>(
        builder: (context, state) {
          if (state is ClientExpiringSoonState && state.expiringClients.isNotEmpty) {
            return ListView.builder(
              itemCount: state.expiringClients.length,
              itemBuilder: (context, index) {
                final client = state.expiringClients[index];
                return ListTile(
                  title: Text(client.clientName),
                  subtitle: Text('Expires on: ${client.subscriptionEnd}'),
                  trailing: const Icon(Icons.warning, color: Colors.red),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'لا يوجد أي اي إشعارات',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }
}
