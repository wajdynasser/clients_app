import 'package:clients/data/model/clients_model.dart';
import 'package:clients/presentation/widget/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'more_vert.dart';

class ListTileScreen extends StatelessWidget {
  final Client client;

  const ListTileScreen({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    // Determine tile color and text color based on subscriptionDuration
    Color tileColor;
    Color textColor;

    if (client.subscriptionDuration == 0) {
      tileColor = Colors.red;
      textColor = Colors.white;
    } else if (client.subscriptionDuration == 1) {
      tileColor = Colors.yellow;
      textColor = Colors.black;
    } else {
      tileColor = Colors.grey;
      textColor = Colors.black;
    }

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/Netflix.png'),
          backgroundColor: Colors.black,
        ),
        title: Text(
          client.clientName ?? '',
          style: TextStyle(color: textColor),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              client.subscriptionEmail ?? '',
              style: TextStyle(color: textColor),
            ),
            Text(
              (client.subscriptionDuration ?? '').toString(),
              style: TextStyle(color: textColor),
            ),
          ],
        ),
        trailing: MoreOptionsMenu(client: client),
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return ShowAlertDialog(client: client);
          },
        ),
      ),
    );
  }
}
