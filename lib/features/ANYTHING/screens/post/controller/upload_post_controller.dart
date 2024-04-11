import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/model/post_model.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/model/video_model.dart'; // Adjust import path if necessary
import 'package:video_compress_plus/video_compress_plus.dart';

class UploadPostController extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> _uploadImageToStorage(String id, String postPath) async {
    Reference ref = firebaseStorage.ref().child('post').child(id);

    UploadTask uploadTask = ref.putFile(File(postPath));

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> _generateThumbnail(String postPath) async {
    // You may need to implement logic here to generate a thumbnail from the image.
    // For simplicity, I'm assuming that imagePath directly points to the image file.
    // You may use image processing libraries like image/image.dart to generate thumbnails.
    // Alternatively, if you have predefined thumbnails for images, you can return that directly.
    return ''; // Replace this line with your thumbnail generation logic.
  }

  uploadImage(String description, String caption, String postPath) async {
   // try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(uid).get();
// get id

      var allDocs = await _firestore.collection('post').get();
      int len = allDocs.docs.length;

      String imageUrl = await _uploadImageToStorage("ImagePost $len", postPath);
      String thumbnailUrl = await _generateThumbnail(postPath);

      Post post = Post(
        username: (userDoc.data()! as Map<String, dynamic>)['Username'],
        
        uid: uid,
        id: "ImagePost $len",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        description: description,
        caption: caption,
        postUrl: imageUrl, // Corrected variable name
        profilePhoto:
            (userDoc.data()! as Map<String, dynamic>)['ProfilePicture'],
        thumbnail: thumbnailUrl,
      );

      Get.back();

      await _firestore.collection('post').doc('ImagePost $len').set(
            post.toJson(), // Corrected method call
          );
/* }    catch (e) {
      Get.snackbar("Error Uploading Image", e.toString());
    }*/
  }
}
