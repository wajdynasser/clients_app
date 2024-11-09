import 'package:clients/data/model/clients_model.dart';
import 'package:clients/presentation/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../constant/string.dart';
import '../../domain/client_cubit.dart';

class AddSubscription extends StatefulWidget {
  const AddSubscription({super.key, required this.client});

  final Client? client; // Can be null for new client creation

  @override
  _AddSubscriptionState createState() => _AddSubscriptionState();
}

class _AddSubscriptionState extends State<AddSubscription> {
  Client? client;
  int subscriptionDuration = 0;

  @override
  void initState() {
    super.initState();
    client = widget.client?.copyWith(); // Make a copy if client provided

    // Trigger calculation and update duration on init
    if (client != null) {
      BlocProvider.of<ClientCubit>(context)
          .calculateAndSaveSubscriptionDuration(client!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('إضــافة إشتراك'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'الاســـم',
                  prefixIcon: const Icon(Icons.person),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black38,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'المعذرة،يجبإدخال الاسم';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'الإيميــل',
                  prefixIcon: const Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black38,
                      width: 2,
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'المعذرة،يجب إدخال إيميلك';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'رقـم الهاتف',
                  prefixIcon: const Icon(Icons.phone),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black38,
                      width: 2,
                    ),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.length < 9) {
                    return 'رقم الهاتف يجب أن لايقل عن 9 أرقام';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: subscriptionEmailController,
                decoration: InputDecoration(
                  labelText: 'إيميل الإشـتراك',
                  prefixIcon: const Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black38,
                      width: 2,
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'المعذرة، قم بأدخال إيميل الاشتراك';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                  controller: subscriptionDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'تاريخ الإنشــاء',
                    prefixIcon: const Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black38,
                        width: 2,
                      ),
                    ),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    // Example of fixing the error at line 182
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate!);
                      subscriptionDateController.text = formattedDate;

                      context
                          .read<ClientCubit>()
                          .calculateAndSaveSubscriptionDuration(client!
                              .copyWith(subscriptionDate: formattedDate));
                    }
                  }),
              const SizedBox(height: 16.0),
              TextFormField(
                  controller: subscriptionEndController,
                  decoration: InputDecoration(
                    labelText: 'إنتهاء الإشتراك',
                    prefixIcon: const Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black38,
                        width: 2,
                      ),
                    ),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate!);
                      subscriptionEndController.text = formattedDate;

                      context
                          .read<ClientCubit>()
                          .calculateAndSaveSubscriptionDuration(
                              client!.copyWith(subscriptionEnd: formattedDate));
                    }
                  }),
              const SizedBox(height: 16.0),
              BlocBuilder<ClientCubit, ClientState>(
                builder: (context, state) {
                  if (state is SubscriptionDurationUpdated) {
                    subscriptionDuration = state.remainingDays;
                  }
                  return Text(
                    'مدة الإشتراك: $subscriptionDuration أيام',
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              buildButton(
                text: isUpdate ? 'تعديل ' : 'حفظ ',
                context: context,
                client: client,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
