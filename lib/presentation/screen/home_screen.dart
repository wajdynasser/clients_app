import 'package:clients/presentation/screen/add_subscription.dart';
import 'package:clients/presentation/widget/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/client_cubit.dart';
import '../shared/component.dart';
import '../widget/notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ClientCubit cubit = BlocProvider.of<ClientCubit>(context);

    return BlocConsumer<ClientCubit, ClientState>(
      listener: (context, state) {
        if (state is CreateClientLoaded) {
          showMessage(
            context: context,
            content: const Text(
              'تم الحفظ..',
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontFamily: 'Arabic-Font'),
            ),
            color: Colors.teal,
          );
        } else if (state is CreateClientFailed) {
          showMessage(
            context: context,
            content: const Text(
              'فشل الحفظ..',
              style: TextStyle(
                  fontSize: 18, color: Colors.teal, fontFamily: 'Arabic-Font'),
            ),
            color: Colors.red,
          );
        }
        if (state is UpdateClientLoaded) {
          showMessage(
            context: context,
            content: const Text(
              'تم التعديل',
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontFamily: 'Arabic-Font'),
            ),
            color: Colors.teal,
          );
        }
        if (state is DeleteClientLoaded) {
          showMessage(
            context: context,
            content: const Text(
              'تم الحــذف..',
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontFamily: 'Arabic-Font'),
            ),
            color: Colors.teal,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal.shade200,
            title: const Text('الإشتـــراكات'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  cubit.checkSubscriptionExpiry(); // Trigger check
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExpiringSubscriptionsScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: cubit.allClients.isNotEmpty
                ? ListView.builder(
                    itemCount: cubit.allClients.length,
                    itemBuilder: (context, index) {
                      return ListTileScreen(client: cubit.allClients[index]);
                    },
                  )
                : const Center(
                    child: Text(
                      'لا يوجـد بيانات.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddSubscription(
                      client: null), // Pass null for new client creation
                ),
              );
            },
            tooltip: 'أضافة إشتراك',
            child: const Icon(
              Icons.add,
              color: Colors.teal,
            ),
          ),
        );
      },
    );
  }
}
