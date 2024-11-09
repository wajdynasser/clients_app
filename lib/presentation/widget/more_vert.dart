import 'package:clients/presentation/screen/add_subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constant/string.dart';
import '../../domain/client_cubit.dart';
import '../../data/model/clients_model.dart';

class MoreOptionsMenu extends StatelessWidget {
  final Client client; // Accept the Client object to update or delete

  const MoreOptionsMenu({
    super.key,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) async {
        if (value == 'Update') {
          print(isUpdate);
          isUpdate=true;
          print(isUpdate);
          client.id=client.id;
          nameController.text = client.clientName;
          emailController.text = client.clientEmail;
          phoneController.text = client.clientNumber;
          subscriptionEmailController.text = client.subscriptionEmail;
          subscriptionDateController.text = client.subscriptionDate;
          subscriptionEndController.text = client.subscriptionEnd;
          // Open a dialog to update client information
          await showDialog(
            context: context,
            builder: (context) {
              return AddSubscription(client: client);
            },
          );
        } else if (value == 'Delete') {
          // Perform delete operation using Cubit
          BlocProvider.of<ClientCubit>(context).deleteClient(id: client.id!);
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'Update',
          child: Text('Update'),
        ),
        const PopupMenuItem<String>(
          value: 'Delete',
          child: Text('Delete'),
        ),
      ],
    );
  }
}
