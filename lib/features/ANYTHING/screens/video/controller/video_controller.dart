import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/controller/authController.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/model/video_model.dart';

class VideoController extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();

    _videoList.bindStream(
        _firestore.collection('videos').snapshots().map((QuerySnapshot query) {
      List<Video> retVal = [];

      for (var element in query.docs) {
        retVal.add(
          Video.fromSnap(element),
        );
      }
      return retVal;
    }));
  }

  // like

  likeVideo(String id) async {
    DocumentSnapshot doc = await _firestore.collection('videos').doc(id).get();

    // Get the current user's UID
    var uid = AuthenticationRepository.instance.user.uid;

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await _firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await _firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
