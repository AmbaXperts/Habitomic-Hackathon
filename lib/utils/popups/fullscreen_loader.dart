import '/common/widgets/loader/animation_loader.dart';
import '/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/helpers/helper_function.dart';

class FullScreenloader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!, // for overlay disaply
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!)
              ? TColors.dark
              : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(children: [
            const SizedBox(height: 200),
            AnimationLoaderWidget(text: text, animation: animation),
          ]),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!)
        .pop(); // close the dialoge using navigator
  }
}
