import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class authMethod {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> userData = {};

  Future<String> addProduct({
    required List<TextEditingController> habits,
    required String commTitle,
    required String commBio,
    required Uint8List commImg,
    required List videos,
  }) async {
    String res = 'some error occurred';
    try {
      String url = await uploadingimage('community', commImg);

      if (commTitle.isNotEmpty && commBio.isNotEmpty) {
        String commID = const Uuid().v1();

        await _firestore.collection('community').doc(commID).set({
          'name': commTitle,
          'profilepic': url,
          'admins': [_auth.currentUser!.uid],
          'members': [_auth.currentUser!.uid],
          'rating': 0,
        });

        for (var i = 0; i < habits.length; i++) {
          if (habits[i].text.isNotEmpty) {
            String habitID = const Uuid().v1();
            await _firestore
                .collection('community')
                .doc(commID)
                .collection('habits')
                .doc(habitID)
                .set({
              'name': habits[i].text,
              'isachieved': false,
              'week': i % 4 + 1,
            });
          }
        }

        for (var i = 0; i < videos.length; i++) {
          if (videos[i][0].text.isNotEmpty && videos[i][1].text.isNotEmpty) {
            String videoID = const Uuid().v1();
            await _firestore
                .collection('community')
                .doc(commID)
                .collection('video')
                .doc(videoID)
                .set({
              'name': videos[i][0].text,
              'link': videos[i][0].text,
            });
          }
        }

        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}

final FirebaseStorage _storage = FirebaseStorage.instance;

final FirebaseAuth _auth = FirebaseAuth.instance;
Future<String> uploadingimage(String folderName, Uint8List file) async {
  //
  String postId = const Uuid().v1();
  Reference ref = _storage.ref().child(folderName).child(postId);

  UploadTask upload = ref.putData(file);

  TaskSnapshot snap = await upload;

  String url = await snap.ref.getDownloadURL();

  return await url;
}
