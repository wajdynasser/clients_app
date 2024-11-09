import 'package:clients/constant/string.dart';
import 'package:clients/data/model/clients_model.dart';
import 'package:clients/domain/client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//-----------------build Message SnackBar-----------------
void showMessage(
    {required BuildContext context,
    required Widget content,
    required Color color}) {
  var snackBar = SnackBar(
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    content: content,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
///////////////////

/////////////////////
//-----------------clear Function-----------------//
void clear() {
  isUpdate = false;
  nameController.clear();
  emailController.clear();
  phoneController.clear();
  subscriptionEmailController.clear();
  subscriptionDateController.clear();
  subscriptionEndController.clear();
}

/////////////////////////////////////button for add or update
ElevatedButton buildButton(
    {required String text, required BuildContext context, Client? client}) {
  return ElevatedButton(
    onPressed: () {
      if (formKey.currentState!.validate()) {
        try {
          Navigator.pop(context);
          if (isUpdate) {
            BlocProvider.of<ClientCubit>(context).updateClient(
              client: Client(
                id: client!.id,
                clientName: nameController.text,
                clientEmail: emailController.text,
                clientNumber: phoneController.text,
                subscriptionEmail: subscriptionEmailController.text,
                subscriptionDate: subscriptionDateController.text,
                subscriptionEnd: subscriptionEndController.text,
                // Calculate subscriptionDuration
                subscriptionDuration: DateTime.parse(
                        subscriptionEndController.text)
                    .difference(DateTime.parse(subscriptionDateController.text))
                    .inDays,
              ),
            );
          } else {
            BlocProvider.of<ClientCubit>(context).insertClient(
                client: Client(
              clientName: nameController.text,
              clientEmail: emailController.text,
              clientNumber: phoneController.text,
              subscriptionEmail: subscriptionEmailController.text,
              subscriptionDate: subscriptionDateController.text,
              subscriptionEnd: subscriptionEndController.text,
              // Calculate subscriptionDuration
              subscriptionDuration: DateTime.parse(
                      subscriptionEndController.text)
                  .difference(DateTime.parse(subscriptionDateController.text))
                  .inDays,
            ));
          }
          clear();
        } catch (e) {
          print(e.toString());
        }
      }
    },
    child: Text(text),
  );
}
