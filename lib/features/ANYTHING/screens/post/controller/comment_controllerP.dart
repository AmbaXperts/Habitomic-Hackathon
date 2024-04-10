import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/model/comment_modelp.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/model/comment.dart';

class PCommentController extends GetxController {
  final Rx<List<PComment>> _pcomments = Rx<List<PComment>>([]);

  //firebase firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<PComment> get pcomments => _pcomments.value;

  String _ppostId = "";

  updatePPostId(String id) {
    _ppostId = id;
    getPComment();
  }

  getPComment() async {
    _pcomments.bindStream(_firestore
        .collection('post')
        .doc(_ppostId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot query) {
      List<PComment> retValue = [];
      for (var element in query.docs) {
        retValue.add(PComment.fromSnap(element));
      }
      return retValue;
    }));
  }

  PpostComment(String pcommentText) async {
    if (pcommentText.isNotEmpty) {
      DocumentSnapshot userDoc = await _firestore
          .collection('Users')
          .doc(AuthenticationRepository.instance.user.uid)
          .get();

      var allDocs = await _firestore
          .collection('post')
          .doc(_ppostId)
          .collection('comments')
          .get();
      int len = allDocs.docs.length;

      PComment pcomment = PComment(
          username: (userDoc.data()! as dynamic)['Username'],
          comment: pcommentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto: (userDoc.data()! as dynamic)['ProfilePicture'],
          uid: AuthenticationRepository.instance.user.uid,
          id: 'Comment $len');
      await _firestore
          .collection('post')
          .doc(_ppostId)
          .collection('comments')
          .doc('Comment $len')
          .set(
            pcomment.tojson(),
          );

      DocumentSnapshot doc =
          await _firestore.collection('post').doc(_ppostId).get();
      await _firestore.collection('post').doc(_ppostId).update({
        'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
      });
    }
  }

  likePComment(String id) async {
    var uid = AuthenticationRepository.instance.user.uid;
    DocumentSnapshot doc = await _firestore
        .collection('post')
        .doc(_ppostId)
        .collection('comments')
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await _firestore
          .collection('post')
          .doc(_ppostId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await _firestore
          .collection('post')
          .doc(_ppostId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
