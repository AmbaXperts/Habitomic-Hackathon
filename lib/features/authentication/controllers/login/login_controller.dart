import '/data/repositories/repositories.authentication/authentication_repository.dart';
import '/features/personalization/controllers/user_controller.dart';
import '/localization/internet/network_manager.dart';
import '/utils/constants/image_strings.dart';
import '/utils/popups/fullscreen_loader.dart';
import '/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  // variables
  final rememberMe = false.obs;
  final hidepassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    // Initialize email and password fields if Remember Me is selected
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

// email and password signin
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start loading
      FullScreenloader.openLoadingDialog(
          'We are Processing your information...', TImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenloader.stopLoading();
        return;
      }

      // Form validation
      if (!loginFormKey.currentState!.validate()) {
        FullScreenloader.stopLoading();
        return;
      }

      //save data if remeber me is selected

      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // login user using email and password authentication
      final UserCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // remove loader
      FullScreenloader.stopLoading();
      // Show success message
      /* Loader.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been created! Verify email to continue.');*/

      // redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Exception handling
      FullScreenloader.stopLoading(); // Stop loader
      Loader.errorSnackBar(
          title: 'Oh Snap!', message: _getErrorMessage(e.toString()));
    }
  }

  Future<void> googleSignIn() async {
    try {
      FullScreenloader.openLoadingDialog(
          'Logging you in', TImages.docerAnimation);

//check internet connectivity

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenloader.stopLoading();
        return;
      }

// Google authentication
      final UserCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

// save user record

      await userController.saveUserRecord(UserCredentials);

      FullScreenloader.stopLoading();

// redirect user
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Exception handling
      FullScreenloader.stopLoading(); // Stop loader
      Loader.errorSnackBar(
          title: 'Oh Snap!', message: _getErrorMessage(e.toString()));
    }
  }

  // Method to extract specific error messages from exceptions
  String _getErrorMessage(String error) {
    // Add specific error message mappings based on exception types
    if (error.contains('no user record')) {
      return 'User not found. Please check your credentials.';
    } else if (error.contains('email is badly formatted')) {
      return 'Invalid email format. Please enter a valid email address.';
    } else if (error.contains('password is invalid')) {
      return 'Invalid password. Please try again.';
    } else {
      return 'An error occurred. Please try again later.';
    }
  }
}
