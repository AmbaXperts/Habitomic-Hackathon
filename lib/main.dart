import '/app.dart';
import '/data/repositories/repositories.authentication/authentication_repository.dart';
import '/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
//add widget binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

// initalize local storage
  await GetStorage.init();

//await splash until item load

//FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
// initalize firebase and authentication repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const App());
}
