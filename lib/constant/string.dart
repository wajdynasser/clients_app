


import 'package:flutter/material.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
TextEditingController subscriptionEmailController =
TextEditingController();
final TextEditingController subscriptionDateController =
TextEditingController();
final TextEditingController subscriptionEndController = TextEditingController();

bool isUpdate=false;


GlobalKey<FormState> formKey = GlobalKey<FormState>();
