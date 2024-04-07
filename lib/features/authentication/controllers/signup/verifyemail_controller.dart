import 'dart:async';

import '/common/widgets/sucess_screen/sucessscreen.dart';
import '/data/repositories/repositories.authentication/authentication_repository.dart';
import '/utils/constants/image_strings.dart';
import '/utils/constants/text_strings.dart';
import '/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();
  bool emailVerificationSent =
      false; // Track if email verification has been sent

  @override
  void onInit() {
    // Check if email verification has already been sent
    if (!emailVerificationSent) {
      sendEmailVerification();
    }
    setTimerForAutoredirect();
    super.onInit();
  }

  // send Email verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      emailVerificationSent = true; // Update flag
      Loader.successSnackBar(
          title: 'Email Sent',
          message: 'Please Check your inbox and verify your email.');
    } catch (e) {
      Loader.successSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  //timer to automatically redirect on email verification
  setTimerForAutoredirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();

      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SucessScreen(
              image: TImages.successfullyRegistrationAnimation,
              title: TTexts.youraccountcreatedSucessfully,
              subTitle: TTexts.youraccountcreatedSucessfullysub,
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect(),
            ));
      }
    });
  }
  // manually check if email verified

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SucessScreen(
            image: TImages.successfullyRegistrationAnimation,
            title: TTexts.youraccountcreatedSucessfully,
            subTitle: TTexts.youraccountcreatedSucessfullysub,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ));
    }
  }
}
