import '/localization/internet/network_manager.dart';
import 'package:get/get.dart';

class generalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}
