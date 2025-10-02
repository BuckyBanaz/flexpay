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
    if (v.trim().isEmpty) return 'please_enter_email'.tr;
    if (!GetUtils.isEmail(v.trim())) return 'enter_valid_email'.tr;
    return null;
  }

  String? validatePassword(String v) {
    if (v.trim().isEmpty) return 'please_enter_password'.tr;
    if (v.trim().length < 6) return 'minimum_password_length'.tr;
    return null;
  }

  Future<void> signIn() async {
    loading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    loading.value = false;
    Get.back();
    Get.snackbar('signed_in'.tr, 'welcome_back2'.tr, snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> signUp() async {
    loading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    loading.value = false;
    Get.back();
    Get.snackbar('account_created'.tr, 'welcome_flexpay'.tr, snackPosition: SnackPosition.BOTTOM);
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
