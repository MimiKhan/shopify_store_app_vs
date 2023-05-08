import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/login_controller.dart';
import 'package:shopify_store_app/core/utils/size_utils.dart';
import 'package:shopify_store_app/views/login/components/my_button.dart';
import 'package:shopify_store_app/views/login/components/my_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final loginController = Get.find<LoginController>();

  final emailController = TextEditingController();

  void showDoneDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("We have sent you the email regarding resetting your password."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  sendCode() async{
    String email = emailController.text;

    await loginController.forgottenPassword(email).whenComplete(() => showDoneDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          title: const Text(
            'Forgot Password',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                Flexible(
                  fit: FlexFit.loose,
                  flex: 2,
                  child: Text(
                    'We need your registration email to send you password reset email!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                    softWrap: true,
                  ),
                ),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  text: "Send Code",
                  onTap: sendCode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
