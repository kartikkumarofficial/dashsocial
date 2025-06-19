import 'package:dashsocial/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/auth_controller.dart';
import '../../widgets/text_field_box.dart';
import 'package:dashsocial/services/auth_service.dart';

class SignUpPage extends StatefulWidget {

  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthController authController = Get.put(AuthController());

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.1),
                Text(
                  'Create Account',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                TextFieldBox(
                  hint: 'Name',
                  icon: Icons.person,
                  controller: authController.nameController,
                ),
                const SizedBox(height: 20),
                TextFieldBox(
                  hint: 'Email',
                  icon: Icons.email,
                  controller: authController.emailController,
                ),
                const SizedBox(height: 20),
                TextFieldBox(
                  hint: 'Password',
                  icon: Icons.lock,
                  isObscure: true,
                  controller: authController.passwordController,
                ),
                const SizedBox(height: 20),
                TextFieldBox(
                  hint: 'Confirm Password',
                  icon: Icons.lock_outline,
                  isObscure: true,
                  controller: authController.confirmPasswordController,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      authController.signUp();

                    },
                    child: const Text('Sign Up'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
