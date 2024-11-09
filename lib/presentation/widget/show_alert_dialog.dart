import 'package:flutter/material.dart';
import '../../data/model/clients_model.dart';

class ShowAlertDialog extends StatelessWidget {
  final Client client;

  const ShowAlertDialog({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('التفاصيل', textAlign: TextAlign.center),
      content: SizedBox(
        height: 220, // Set a custom height
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('اسم العميل: ${client.clientName}'),
            const SizedBox(height: 8),
            Text('إيميل العميل: ${client.clientEmail}'),
            const SizedBox(height: 8),
            Text('رقم العميل: ${client.clientNumber}'),
            const SizedBox(height: 8),
            Text('إيميل الإشتراك: ${client.subscriptionEmail}'),
            const SizedBox(height: 8),
            Text('تاريخ الإشتراك: ${client.subscriptionDate}'),
            const SizedBox(height: 8),
            Text('إنتهاء الإشتراك: ${client.subscriptionEnd}'),
            const SizedBox(height: 8),
            Text('الايـام المتبقية: ${client.subscriptionDuration}'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
