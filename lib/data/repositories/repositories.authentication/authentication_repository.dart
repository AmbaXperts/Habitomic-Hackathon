import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '/data/repositories/user/user_repository.dart';
import '/features/authentication/screens/login/login.dart';
import '/features/authentication/screens/onboarding/onboarding.dart';
import '/features/authentication/screens/signup/verify_email.dart';
import '/navigation_menu.dart';
import '/utils/exception/firebase_exception.dart';
import '/utils/exception/firebaseauthexception.dart';
import '/utils/exception/format_exception.dart';
import '/utils/exception/platform_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;

//firebase firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Firebase Storage instance
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  //variable

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // get authenticated user data
  User? get authUser => _auth.currentUser;

  //called from main.dart on app launc
  @override
  void onReady() {
    FlutterNativeSplash.remove();

    screenRedirect();
  }

  //function to show relevant screen
  @override
  void onInit() {
    super.onInit();
    _user = Rx<User?>(_auth.currentUser);
    _pickedImage = Rx<File?>(null);
    initialize();
  }

  void initialize() {
    screenRedirect();
  }

  void screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: user.email));
      }
    } else {
      final deviceStorage = GetStorage();
      deviceStorage.writeIfNull('isFirstTime', true);

      if (deviceStorage.read('isFirstTime') != true) {
        Get.offAll(() => LoginScreen());
      } else {
        Get.offAll(() => OnBoardingScreen());
      }
    }
  }
  /*
  screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      // local storage
      deviceStorage.writeIfNull('isFirstTime', true);
      // check if user first time
      deviceStorage.read('isFirsTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnBoardingScreen());
    }
  }*/

  // email auth- signin or login
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again";
    }
  }

  //eail auth- register

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again";
    }
  }

  /// user post

  Future<String> UserPosts(
    String uid,
    String username,
    String discription,
    String Userphotourl,
    String postphotourl,
    List following,
    List like,
  ) async {
    String res = 'something occured';
    try {
      String userPostId = Uuid().v1();
      if (postphotourl.isNotEmpty && discription.isNotEmpty) {
        await _firestore
            .collection('posts')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('post')
            .doc(userPostId)
            .set({
          'uid': uid,
          'username': username,
          'UserphotoUrl': Userphotourl,
          'PostphotoUrl': postphotourl,
          'discription': discription,
          'following': following,
          'like': like,
        });
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> createCommunity({
    required String commName,
    required String commOwner,
    required Uint8List commPicture,
    required String commBio,
    required String? commPdf,
    required String? commaudio,
    required List<Map<String, dynamic>> habits,
    required List members,
    required List videoTumnel,
    required List videoLink,
    required List videoName,
  }) async {
    String res = 'Error : UnExpected error';
    try {
      String Yuid = Uuid().v1();
      await _firestore.collection('Ycommunity').doc(Yuid).set({
        'commName': commName,
        'commPicture': commPicture,
        'commTumnel': videoTumnel,
        'commVideoLink': videoLink,
        'commVideoName': videoName,
        'commPdf': commPdf,
        'commAudio': commaudio,
        'commMembers': members,
        'commHabits': habits,
        'commOwner': commOwner,
      });
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // for comment in the feed screen

  Future<String> PostComment(
    String clickedUid,
    String CurrentUsername,
    String ClickedUsername,
    String ClickeduserPhoto,
    String CurrentuserPhoto,
    String discription,
    String currentUserUid,
  ) async {
    String res = 'something occured';
    try {
      String kk = Uuid().v1();
      await _firestore
          .collection('comments')
          .doc(clickedUid)
          .collection('comment')
          .doc(kk)
          .set({
        'CurrentUid': currentUserUid,
        'Currentusername': CurrentUsername,
        'discription': discription,
        'CureentphotoUrl': CurrentuserPhoto,
      });
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //email auth- reauthenticate user

  //email auth- mail verification

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again";
    }
  }
  //email auth  - forgot password

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again";
    }
  }

  /*------------------------------------social signin---------------------------*/

  // gogle auth- GOOGLE

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // triger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      //obtain the auth details from request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;
      //create new credentisal
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // after signin return the usercredential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('something went wrong: $e');
      return null;
    }
  }

  //faceboo auth- FACEBOOK

  /*--------------------------------end federated identity and social signin -------------*/

  // logout user- valid for any authentication
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again";
    }
  }

//re autheticate user
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      // create a credential
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      // reauthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again";
    }
  }
  // delete user- remove user and any firestore account

  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something Went Wrong. Please try again";
    }
  }
}
