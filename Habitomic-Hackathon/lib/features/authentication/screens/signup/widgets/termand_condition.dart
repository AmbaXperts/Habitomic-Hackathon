import '/features/authentication/controllers/signup/signup_controller.dart';
import '/utils/constants/colors.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermandCondition extends StatelessWidget {
  const TermandCondition({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final controller = SignupController.instance;
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) => controller.privacyPolicy.value =
                    !controller.privacyPolicy.value),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '  ${TTexts.iAgreedTo} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: TTexts.privecypolicy,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? TColors.white : TColors.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor:
                          dark ? TColors.white : TColors.primaryColor,
                    )),
            TextSpan(
                text: ' ${TTexts.and} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: '  ${TTexts.termofuse} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? TColors.white : TColors.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor:
                          dark ? TColors.white : TColors.primaryColor,
                    )),
          ]),
        ),
      ],
    );
  }
}
