import '/data/repositories/repositories.authentication/authentication_repository.dart';
import '/features/authentication/screens/password_configration/reser_password.dart';
import '/localization/internet/network_manager.dart';
import '/utils/constants/image_strings.dart';
import '/utils/popups/fullscreen_loader.dart';
import '/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // send reset password email
  sendPasswordResetEmail() async {
    try {
      FullScreenloader.openLoadingDialog(
          'Processing your request', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenloader.stopLoading();
        return;
      }

      // Form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        FullScreenloader.stopLoading();
        return;
      }

      // send email to reset password

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      FullScreenloader.stopLoading();

      // show sucess screen
      Loader.successSnackBar(
          title: 'Email sent',
          message: 'Email Link sent to reser your password'.tr);

      // redirect
      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      FullScreenloader.stopLoading();
      Loader.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      FullScreenloader.openLoadingDialog(
          'Processing your request', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenloader.stopLoading();
        return;
      }

      // send email to reset password

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      FullScreenloader.stopLoading();

      // show sucess screen
      Loader.successSnackBar(
          title: 'Email sent',
          message: 'Email Link sent to reser your password'.tr);
    } catch (e) {}
  }
}
