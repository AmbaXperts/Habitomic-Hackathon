import '/common/styles/spacing_styles.dart';
import '/common/widgets/login_signup/form_divider.dart';
import '/features/authentication/screens/login/widgets/login_form.dart';
import '/features/authentication/screens/login/widgets/login_header.dart';
import '/common/widgets/login_signup/social_button.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';
import '/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarWeight,
          child: Column(
            children: [
              const TLoginHeader(),
              const TLoginForm(),
              TFormDivider(
                divdierText: TTexts.signin.capitalize!,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
