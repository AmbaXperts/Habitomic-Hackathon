import '/data/repositories/user/user_repository.dart';
import '/features/personalization/controllers/user_controller.dart';
import '/features/personalization/screens/profile/profile.dart';
import '/localization/internet/network_manager.dart';
import '/utils/constants/image_strings.dart';
import '/utils/popups/fullscreen_loader.dart';
import '/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initalizeNames();
    super.onInit();
  }

  Future<void> initalizeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
    userName.text = userController.user.value.username;
  }

  Future<void> updateUserName() async {
    try {
      FullScreenloader.openLoadingDialog(
          "We are updating your information", TImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenloader.stopLoading();
        return;
      }

      // Form validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        FullScreenloader.stopLoading();
        return;
      }

      // update user's first and last name in firebase firestore

      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim(),
        'Username': userName.text.trim()
      };

      await userRepository.updateSingleField(name);

      FullScreenloader.stopLoading();

      Loader.successSnackBar(
          title: "Congratulations", message: 'Your Name has been Updated');

      // redirect to privious screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      FullScreenloader.stopLoading();
      Loader.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
