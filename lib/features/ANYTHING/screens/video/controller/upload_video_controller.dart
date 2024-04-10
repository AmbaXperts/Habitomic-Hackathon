import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/model/video_model.dart';
import 'package:video_compress_plus/video_compress_plus.dart';

class UploadVideoController extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // FirebaseStorage instance
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  _compressVideo(String videoPath) async {
    final compressVideo = await VideoCompress.compressVideo(videoPath,

        quality: VideoQuality.MediumQuality, );
    // here we can add different functionality like edit and so on





    return compressVideo!.file;
  }

  Future<String> _uploadeVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

// upload tumbnailimage

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);

    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // upload video function

  uploadVideo(String songName, String caption, String videoPath) async {
    //try {
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(uid).get();
// get id

      var allDocs = await _firestore.collection('videos').get();
      int len = allDocs.docs.length;

      String videourl = await _uploadeVideoToStorage("Video $len", videoPath);
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);

      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['Username'],
        uid: uid,
        id: "Video $len",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videourl: videourl,
        profilePhoto:
            (userDoc.data()! as Map<String, dynamic>)['ProfilePicture'],
        thumbnail: thumbnail,
      );

      Get.back();

      await _firestore.collection('videos').doc('Video $len').set(
            video.tojson(),
          );
   /* } catch (e) {
      Get.snackbar("Error Uploading Video", e.toString());
    }*/
  }
}
