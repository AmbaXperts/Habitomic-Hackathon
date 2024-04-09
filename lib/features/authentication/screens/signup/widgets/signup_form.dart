import '/features/authentication/controllers/signup/signup_controller.dart';
import '/features/authentication/screens/signup/widgets/termand_condition.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/helpers/helper_function.dart';
import '/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) =>
                      TValidator.ValidateEmptyText('First name', value),
                  controller: controller.firstName,
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  validator: (value) =>
                      TValidator.ValidateEmptyText('Last name', value),
                  controller: controller.lastName,
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              )
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            validator: (value) =>
                TValidator.ValidateEmptyText('username', value),
            controller: controller.username,
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.username,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            validator: (value) => TValidator.validateEmail(value),
            controller: controller.email,
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            validator: (value) => TValidator.validatePhoneNumber(value),
            controller: controller.phoneNumber,
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          Obx(
            () => TextFormField(
              validator: (value) => TValidator.validatePassword(value),
              controller: controller.password,

              // expands must be true here
              obscureText: controller.hidePassword.value,

              decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      icon: Icon(controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye))),
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Terms and conditions
          const TermandCondition(),

          const SizedBox(height: TSizes.spaceBtwSections),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(TTexts.createaccount),
            ),
          ),
        ],
      ),
    );
  }
}
