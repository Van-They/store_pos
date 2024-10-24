import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/screen/login/login_controller.dart';
import 'package:store_pos/widget/text_widget.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextWidget(text: "Login Screen"),
      ),
    );
  }
}
