import '/common/model/user/user_model.dart';
import '/data/repositories/repositories.authentication/authentication_repository.dart';
import '/data/repositories/user/user_repository.dart';
import '/features/authentication/screens/login/login.dart';
import '/features/personalization/screens/profile/Widgets/edit_profiles/re_Auth_user_login_form.dart';
import '/localization/internet/network_manager.dart';
import '/utils/constants/image_strings.dart';
import '/utils/constants/sizes.dart';
import '/utils/popups/fullscreen_loader.dart';
import '/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  final hidePassword = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();

    fetchUserRecord();
  }

// fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }
  // save user record from any registration provider

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        //c convert first and last name
        final nameParts =
            UserModel.nameParts(userCredentials.user!.displayName ?? '');
        final username =
            UserModel.generateUsername(userCredentials.user!.displayName ?? '');

        // map the data

        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userCredentials.user!.email ?? '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',
        );

// save user data
        final userRepository = Get.put(UserRepository());
        await userRepository.saveUserRecord(user);

        print(
            'stored and saved sucess fully ==============================\n=========================\n=========================\n====');
      }
    } catch (e) {
      Loader.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. you can rre-save your data in your profiel');
    }
  }

  // delete account warning

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TSizes.md),
        title: 'Delete Account',
        middleText:
            "Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.",
        confirm: ElevatedButton(
          onPressed: () async => deleteuserAccount(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: const BorderSide(color: Colors.red)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Delete'),
          ),
        ),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text("Cancel")));
  }

  void deleteuserAccount() async {
    try {
      FullScreenloader.openLoadingDialog("Processing", TImages.docerAnimation);
      // fitsy re authenticate the user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        // re verify auth email

        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          FullScreenloader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          FullScreenloader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      FullScreenloader.stopLoading();
      Loader.warningSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  // re auth before deleteing

  Future<void> reAuthenticationEmailAndPasswordUser() async {
    try {
      FullScreenloader.openLoadingDialog("Processing", TImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenloader.stopLoading();
        return;
      }

      // Form validation
      if (!reAuthFormKey.currentState!.validate()) {
        FullScreenloader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      FullScreenloader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenloader.stopLoading();
      Loader.warningSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
