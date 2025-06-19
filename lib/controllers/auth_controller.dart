import 'package:dashsocial/presentation/screens/dashboard_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    isLoading.value = true;
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {"name": nameController.text.trim()},//final name = Supabase.instance.client.auth.currentUser?.userMetadata?['name']; - can be accessed by this

      );

      if (response.user != null) {
        Get.snackbar('Success', 'Signed up as ${response.user!.email}');
        Get.offAll(DashboardScreen());
      } else {
        Get.snackbar('Sign Up Failed', 'Something went wrong. Try again.');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
      ); //just to make error snack bar smaller and more readable
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
