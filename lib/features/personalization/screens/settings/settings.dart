import '/common/widgets/appbar/appbar.dart';
import '/common/widgets/custome_shapes/primery_header_container.dart';
import '/common/widgets/layouts/list_tiles/setting_menu_tile.dart';
import '/common/widgets/layouts/list_tiles/userprofile_tile.dart';
import '/common/widgets/section_heading.dart';
import '/data/repositories/repositories.authentication/authentication_repository.dart';
import '/features/personalization/screens/profile/profile.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthenticationRepository());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimeryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: TColors.white),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //user profile
                  UserProfileTile(
                      onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const SectionHeading(
                    title: ' ,Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SettingMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set Adress',
                    onTap: () {},
                  ),
                  SettingMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My cart',
                    subTitle: 'Add, remove, and checkot',
                    onTap: () {},
                  ),
                  SettingMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My orders',
                    subTitle: 'in progress and completed',
                    onTap: () {},
                  ),
                  SettingMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank account',
                    subTitle: 'withdraw balance',
                    onTap: () {},
                  ),
                  SettingMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My coupons',
                    subTitle: 'List all discounts',
                    onTap: () {},
                  ),
                  SettingMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subTitle: 'Set any notification',
                    onTap: () {},
                  ),
                  SettingMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subTitle: 'manage data usage',
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const SectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const SettingMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Load Data',
                    subTitle: 'Upload Data ',
                  ),
                  SettingMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'recommondation based on location ',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  SettingMenuTile(
                    icon: Iconsax.security_user,
                    title: 'safe mode',
                    subTitle: 'search result is safe for all ages ',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  SettingMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image quality',
                    subTitle: 'Set image quality t be seen ',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.logout(),
                        child: const Text(TTexts.logout)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
