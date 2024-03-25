import '/features/authentication/screens/login/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  //variable
  final Pagecontroller = PageController();
  Rx<int> currentPageIndex = 0.obs;

  ///void current index ehen page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  //jump to specific dot elect page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    Pagecontroller.jumpTo(index);
  }

  // update current index and jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage();

      if (kDebugMode) {
        print(
            '==========================  GET STORAGE NEXT BUTTON ================  ');
        print(storage.read('isFirstTime'));
      }
      storage.write('isFirstTime', false);

      if (kDebugMode) {
        print(
            '==========================  GET STORAGE NEXT BUTTON ================  ');
        print(storage.read('isFirstTime'));
      }
      Get.offAll(const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      Pagecontroller.jumpToPage(page);
    }
  }

  //update curent index and jump to last page
  void skipPage() {
    currentPageIndex.value = 2;
    Pagecontroller.jumpToPage(2);
  }
}
