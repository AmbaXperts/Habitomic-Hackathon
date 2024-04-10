import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';


class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List<String> thumbnails = [];
    var myVideos = await _firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();

    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
    }

    DocumentSnapshot userDoc =
        await _firestore.collection('Users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String username = userData['Username'];
    String firstname = userData['FirstName'];
    String lastname = userData['LastName'];
    String ProfilePicture = userData['ProfilePicture'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    for (var item in myVideos.docs) {
      likes += (item.data()['likes'] as List).length;
    }
    var followerDoc = await _firestore
        .collection('Users')
        .doc(_uid.value)
        .collection('Follower')
        .get();
    var followingDoc = await _firestore
        .collection('Users')
        .doc(_uid.value)
        .collection('Following')
        .get();
    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    _firestore
        .collection('Users')
        .doc(_uid.value)
        .collection('Follower')
        .doc(AuthenticationRepository.instance.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _user.value = {
      'Follower': followers.toString(),
      'Following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'ProfilePicture': ProfilePicture,
      'Username': username,
       'FirstName': firstname,
        'LastName': lastname,
      'thumbnails': thumbnails,
    };
    update();
  }

  followUser() async {
    var doc = await _firestore
        .collection('Users')
        .doc(_uid.value)
        .collection('Follower')
        .doc(AuthenticationRepository.instance.user.uid)
        .get();

    if (!doc.exists) {
      await _firestore
          .collection('Users')
          .doc(_uid.value)
          .collection('Follower')
          .doc(AuthenticationRepository.instance.user.uid)
          .set({});
      await _firestore
          .collection('Users')
          .doc(AuthenticationRepository.instance.user.uid)
          .collection('Following')
          .doc(_uid.value)
          .set({});
      _user.value.update(
        'Follower',
        (value) => (int.parse(value) + 1).toString(),
      );
    } else {
      await _firestore
          .collection('Users')
          .doc(_uid.value)
          .collection('Follower')
          .doc(AuthenticationRepository.instance.user.uid)
          .delete();
      await _firestore
          .collection('Users')
          .doc(AuthenticationRepository.instance.user.uid)
          .collection('Following')
          .doc(_uid.value)
          .delete();
      _user.value.update(
        'Follower',
        (value) => (int.parse(value) - 1).toString(),
      );
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}