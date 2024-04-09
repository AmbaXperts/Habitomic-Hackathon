import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/model/comment.dart';
class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Comment> get comments => _comments.value;
  String _postId = "";

  updatePostId(String id) {
    _postId = id; // Update the postId variable
    getComment();
  }

  getComment() async {
    _comments.bindStream(_firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Comment> retValue = [];
      for (var element in query.docs) {
        retValue.add(Comment.fromSnap(element));
      }
      return retValue;
    }));
  }

  postComment(String commentText) async {
    if (commentText.isNotEmpty) {
      DocumentSnapshot userDoc = await _firestore
          .collection('Users')
          .doc(AuthenticationRepository.instance.user.uid)
          .get();

      var allDocs = await _firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .get();
      int len = allDocs.docs.length;

      Comment comment = Comment(
          username: (userDoc.data()! as dynamic)['Username'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto: (userDoc.data()! as dynamic)['ProfilePicture'],
          uid: AuthenticationRepository.instance.user.uid,
          id: 'Comment $len');
      await _firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc('Comment $len')
          .set(
            comment.tojson(),
          );

      DocumentSnapshot doc =
          await _firestore.collection('videos').doc(_postId).get();
      await _firestore.collection('videos').doc(_postId).update({
        'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
      });
    }
  }

  likeComment(String id) async {
    var uid = AuthenticationRepository.instance.user.uid;
    DocumentSnapshot doc = await _firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await _firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await _firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
