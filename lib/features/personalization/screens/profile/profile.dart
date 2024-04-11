import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/data/repositories/user/user_repository.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/controller/profile_controller.dart';
import 'package:image_picker/image_picker.dart';

import '/common/widgets/appbar/appbar.dart';
import '/common/widgets/circular_image/circular_image.dart';
import '/common/widgets/section_heading.dart';
import '/features/personalization/controllers/user_controller.dart';
import '/features/personalization/screens/profile/Widgets/edit_profiles/change_name.dart';
import '/features/personalization/screens/profile/Widgets/profile_menu.dart';
import '/utils/constants/image_strings.dart';
import '/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final userRepository = UserRepository.instance;
    final profileController = Get.put(ProfileController());
    String url = "";
    final picker = ImagePicker();
    XFile? pickedFile;

    Future<String> getImgUrl() async {
      if (pickedFile != null) {
        final imageFile = File(pickedFile!.path);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().toString()}');
        final uploadTask = storageRef.putFile(imageFile);

        // Monitor the upload task
        await uploadTask.whenComplete(() {
          // Get the download URL
          storageRef.getDownloadURL().then((imageUrl) {
            // Store the download URL in Firestore
            userRepository.updateSingleField({"ProfilePicture": imageUrl});
            controller.fetchUserRecord();
            profileController
                .updateUserId(AuthenticationRepository.instance.user.uid);
          });
        });
      }
      return "";
    }

    Future<void> pickImage() async {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          pickedFile = pickedImage;
          getImgUrl();
        });
      }
    }

    return Obx(() => Scaffold(
          appBar: const TAppBar(
            title: Text('User Profile'),
            showBackArrow: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        TCircularImage(
                          fit: BoxFit.fill,
                          isNetworkImage: true,
                          image: profileController.user["ProfilePicture"],
                          width: 80,
                          height: 80,
                        ),
                        TextButton(
                            onPressed: () async {
                              pickImage();
                            },
                            child: const Text('Change Profile Picture'))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const SectionHeading(
                    title: 'Profile Information',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ProfileMenu(
                      title: 'Name',
                      value: controller.user.value.fullName,
                      onPressed: () => Get.to(() => const ChangeName())),
                  ProfileMenu(
                      title: 'Username',
                      value: controller.user.value.username,
                      onPressed: () => Get.to(() => const ChangeUserName())),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const SectionHeading(
                    title: 'Personal Information',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ProfileMenu(
                      title: 'User-Id',
                      value: controller.user.value.id,
                      icon: Iconsax.copy,
                      onPressed: () {}),
                  ProfileMenu(
                      title: 'E-mail',
                      value: controller.user.value.email,
                      onPressed: () {}),
                  ProfileMenu(
                      title: 'Phone Numbr',
                      value: controller.user.value.phoneNumber,
                      onPressed: () {}),
                  ProfileMenu(title: 'Gender', value: 'male', onPressed: () {}),
                  ProfileMenu(
                      title: 'NamDate of Birth',
                      value: '10 july, 1995',
                      onPressed: () {}),
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () => controller.deleteAccountWarningPopup(),
                        child: const Text(
                          'Delete Account',
                          style: TextStyle(color: Colors.red),
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
