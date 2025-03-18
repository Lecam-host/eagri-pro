import 'package:eagri_pro/features/auth/presentation/auth_page.dart';
import 'package:flutter/material.dart';

mixin AuthMixin on State<AuthPage> {
  final TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  @override
  void dispose() {
    super.dispose();
    phoneNumberTextEditingController.dispose();
    passwordTextEditingController.dispose();
  }
}
