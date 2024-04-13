import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class YAuth {
  final FirebaseAuth _YAuth = FirebaseAuth.instance;
  final FirebaseFirestore _Yfirestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  ////********************************************* */
  ///Creating community backend

  Future<String> createCommunity({
    required String commName,
    required List commLikes,
    required String commOwner,
    required String? commPicture,
    required String commBio,
    required int commRating,
    required String? commPdf,
    required String? commaudio,
    required List<Map<String, dynamic>> habits,
    required List<Map<String, dynamic>> members,
    required List videoTumnel,
    required List videoLink,
    required List videoName,
    required List<Map<String, dynamic>> habitt,
  }) async {
    String res = 'Error : UnExpected error';
    try {
      String Yuid = Uuid().v1();
      await _Yfirestore.collection('Ycommunity').doc(Yuid).set({
        'commName': commName,
        'commPictrue': commPicture,
        'Uuid': Yuid,
        'commTumnel': videoTumnel,
        'commVideoLink': videoLink,
        'commVideoName': videoName,
        'commPdf': commPdf,
        'commAudio': commaudio,
        'commMembers': members,
        'commHabits': habits,
        'commOwner': commOwner,
        'commBio': commBio,
        'commRating': commRating,
        'commLikes': commLikes,
      });
      await _Yfirestore.collection('Ycommunity')
          .doc(Yuid)
          .collection('achievedHabits')
          .doc(_YAuth.currentUser!.uid)
          .set({
        'habitt': habitt,
      });
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  ////********************************************* */
  ///join the user to community backend

  Future<String> joinUserToCommunity({
    required List members,
    required String uuid,
  }) async {
    String res = 'Error : UnExpected error';

    await _Yfirestore.collection('Ycommunity').doc(uuid).update({
      'commMembers': members,
    });
    return res;

    // if (!commMember.contains(_YAuth.currentUser!.uid)) {
    //   await _Yfirestore.collection('Ycommunity').doc(uuid).update({
    //     'commMembers': members,
    //   });
    // }
  }

  ////********************************************* */
  ///join the user to community backend

  Future<String> updateAchivedHabits({
    required List<Map<String, dynamic>> habitt,
    required String commUid,
    required String whichWeek,
    required int whichIndex,
  }) async {
    String res = 'Error : unExpected error';
    try {
      await _Yfirestore.collection('Ycommunity')
          .doc(commUid)
          .collection('achievedHabits')
          .doc(_YAuth.currentUser!.uid)
          .update({
        'habitt': habitt
        // '${habitt[0][whichWeek][whichIndex]}': !(habitt[0][whichWeek]
        //     [whichIndex])
      }).then((value) {
        return res;
      });

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  ////********************************************* */
  ///join the user to community backend

  Future<String> likeCommunity({
    required String commUid,
    required List commLikes,
    required String likeUserId,
  }) async {
    String res = 'Error : unExpected error';
    try {
      if (commLikes.contains(likeUserId)) {
        await _Yfirestore.collection('Ycommunity').doc(commUid).update({
          'commLikes': FieldValue.arrayRemove([likeUserId]),
        });
      } else {
        await _Yfirestore.collection('Ycommunity').doc(commUid).update({
          'commLikes': FieldValue.arrayUnion([likeUserId]),
        });
      }

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  ////********************************************* */
  ///join the user to community backend

  Future<void> updateRate({
    required String commUid,
    required int rating,
  }) async {
    await _Yfirestore.collection('Ycommunity').doc(commUid).update({
      'commRating': rating + 100,
    });
  }
}
