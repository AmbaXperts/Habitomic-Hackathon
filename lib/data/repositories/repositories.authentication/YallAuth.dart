import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/features/ANYTHING/habit%20track/datetime/date_time.dart';
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
    required List habits,
    required List<Map<String, dynamic>> members,
  }) async {
    String res = 'Error : UnExpected error';
    try {
      String Yuid = Uuid().v1();
      var snappo = await _Yfirestore.collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      var commo = snappo.data()!;
      var comm = commo["JoinComm"];
      comm.add(Yuid);
      Map<String, Map> heatmap = {todaysDateFormatted(): {}};
      await _Yfirestore.collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"JoinComm": comm});

      for (int i = 0; i < habits.length; i++) {
        String Kuid = Uuid().v1();
        await _Yfirestore.collection('Zcommunity')
            .doc(Yuid)
            .collection('habits')
            .doc(Kuid)
            .set({'habitName': habits[i], 'heatmap': heatmap, "uid": Kuid});
        heatmap[todaysDateFormatted()]![Kuid] = false;
      }
      await _Yfirestore.collection('Zcommunity').doc(Yuid).set({
        'commName': commName,
        'commPictrue': commPicture,
        'Uuid': Yuid,
        'commMembers': members,
        'commOwner': commOwner,
        'commBio': commBio,
        'commRating': commRating,
        'commLikes': commLikes,
        'heatmap': heatmap,
      });

      await _Yfirestore.collection('Users')
          .doc()
          .collection("habits")
          .doc(Yuid)
          .set({'heatmap': heatmap});

      print(heatmap);
      res = 'success';
    } catch (e) {
      res = e.toString();
      print(res);
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

    await _Yfirestore.collection('Zcommunity').doc(uuid).update({
      'commMembers': members,
    });

    var query = await _Yfirestore.collection('Zcommunity')
        .doc(uuid)
        .collection("habits")
        .get();
    var starto = query.docs.map((doc) => doc.data()) as Map<String, dynamic>;

    var habits = [];
    Map<String, List> heatmap = {todaysDateFormatted(): []};

    starto.forEach((key, value) {
      habits.add(value["uid"]);
      heatmap[todaysDateFormatted()]![value["uid"]] = false;
    });

    await _Yfirestore.collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("habits")
        .doc(uuid)
        .set({'heatmap': heatmap});

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
        await _Yfirestore.collection('Zcommunity').doc(commUid).update({
          'commLikes': FieldValue.arrayRemove([likeUserId]),
        });
      } else {
        await _Yfirestore.collection('Zcommunity').doc(commUid).update({
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
    await _Yfirestore.collection('Zcommunity').doc(commUid).update({
      'commRating': rating + 100,
    });
  }
}
