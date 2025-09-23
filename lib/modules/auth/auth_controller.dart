import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // text controllers used by both sheets
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();

  final RxBool passwordVisible = false.obs;
  final RxBool confirmPasswordVisible = false.obs;
  final RxBool rememberMe = false.obs;
  final RxBool agreeTos = false.obs;

  final RxBool loading = false.obs;

  // simple validations (demo)
  String? validateEmail(String v) {
    if (v.trim().isEmpty) return 'Please enter email';
    if (!GetUtils.isEmail(v.trim())) return 'Enter valid email';
    return null;
  }

  String? validatePassword(String v) {
    if (v.trim().isEmpty) return 'Please enter password';
    if (v.trim().length < 6) return 'Minimum 6 characters';
    return null;
  }

  Future<void> signIn() async {
    loading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // mock api
    loading.value = false;
    // demo: close sheet and show snackbar
    Get.back();
    Get.snackbar('Signed In', 'Welcome back!', snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> signUp() async {
    loading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // mock api
    loading.value = false;
    Get.back();
    Get.snackbar('Account Created', 'Welcome to Flex Pay!', snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    passCtrl.dispose();
    confirmPassCtrl.dispose();
    super.onClose();
  }
}
