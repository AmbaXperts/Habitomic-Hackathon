import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/features/ANYTHING/habit%20track/datetime/date_time.dart';
import 'package:habitomic_app/utils/constants/image_strings.dart';
import 'package:habitomic_app/utils/popups/fullscreen_loader.dart';
import 'package:habitomic_app/utils/popups/loaders.dart';
import 'package:uuid/uuid.dart';

class CommunityController extends GetxController {
  final Rx<Map<String, dynamic>> _comm = Rx<Map<String, dynamic>>({});
  Rx<List> _act_habit_list = Rx<List>([]);
  Map<String, dynamic> heatmap = {};
  Rx<Map<DateTime, int>> heatMapDataSet = Rx<Map<DateTime, int>>({});
  Rx<String> startdate = "".obs;

  Map<String, dynamic> get comm => _comm.value;
  List get habits => _act_habit_list.value;

  List todayHabit = [].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<String> _uid = "".obs;

  updateCommId(String uid) async {
    _uid.value = uid;

    await getCommData().then((_) {
      // Once getCommData() completes, call getHabitData()
      return getHabitData();
    });
  }

  getCommData() async {
    try {
      heatMapDataSet.value = {};
      // Initialize variables
      heatmap = {};

      // Retrieve user document from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('Zcommunity').doc(_uid.value).get();
      var detailo = await _firestore
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("habits")
          .doc(_uid.value)
          .get();

      var obso = detailo.data()!["heatmap"];
      heatmap = obso;
      print(obso);

      print("get.x $heatmap");
      // Define a function to listen for changes in habits collection

      // Parse the retrieved data from Firestore
      final commData = userDoc.data()! as Map<String, dynamic>;

      // Extract necessary data from commData
      List<dynamic> commLikes = commData["commLikes"];

      // Populate heatmap map

      // Extract other necessary data from commData
      String uuid = _uid.value;
      String commOwner = commData["commOwner"];
      String bio = commData["commBio"];
      String commPicture = commData["commPictrue"] ?? ""; // Corrected key name
      String commName = commData["commName"];
      List<Map<String, dynamic>> members =
          List<Map<String, dynamic>>.from(commData["commMembers"]);
      int rating = commData["commRating"];

      // Update _comm value
      _comm.value = {
        "commLikes": commLikes,
        "heatmap": heatmap,
        "uuid": uuid,
        "commOwner": commOwner,
        "bio": bio,
        "commPicture": commPicture,
        "commName": commName,
        "rating": rating,
        "members": members,
      };

      // Populate todayHabit list

      // Update UI
      update();
    } catch (e) {
      print(e);
    }
  }

  getHabitData() async {
    todayHabit = [].obs;
    try {
      // Fetch habits data from Firestore
      var snapshot = await _firestore
          .collection("Zcommunity")
          .doc(_uid.value)
          .collection("habits")
          .get();

      // Process fetched data and update _act_habit_list
      _act_habit_list.value = [];
      snapshot.docs.forEach((doc) {
        var kelp = doc.data();
        print("keckkks $kelp");
        _act_habit_list.value.add(kelp);
      });
      print("new $_act_habit_list");

      // Populate todayHabit based on _act_habit_list
      if (heatmap.containsKey(todaysDateFormatted())) {
        heatmap[todaysDateFormatted()]?.forEach((key, value) {
          var numo = "";
          _act_habit_list.value.forEach((element) {
            if (element["uid"] == key) {
              numo = element["habitName"];
            }
          });
          todayHabit.add([key, value, numo]);
        });
      } else {
        _act_habit_list.value.forEach(
          (element) {
            todayHabit.add([element["uid"], false, element["habitName"]]);
          },
        );
      }

      // Load heatmap
      print("going to load the heatmap");
      loadHeatMap();
      print("loaded the heatmap");

      // Update UI
      update();
    } catch (e) {
      // Handle errors
      print("An error occurred: $e");
      // You can add more specific error handling here
    }
  }

  pushtoFirebase(uid, boolo) async {
    var detailo = await _firestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("habits")
        .doc(_uid.value)
        .get();
    var usero = await _firestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    var obso = detailo.data()!["heatmap"];
    var rato = usero.data()!["Rating"];
    var mapo = {};
    todayHabit.forEach((element) {
      mapo[element[0]] = element[1];
    });
    if (boolo) {
      rato += 40;
    }
    obso[todaysDateFormatted()] = mapo;
    await _firestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("habits")
        .doc(_uid.value)
        .update({"heatmap": obso});
    await _firestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"Rating": rato});
    updateCommId(uid);

    update();
  }

  addDataToFireStore(namo) async {
    try {
      String Yuid = Uuid().v1();
      await _firestore
          .collection("Zcommunity")
          .doc(_uid.value)
          .collection("habits")
          .doc(Yuid)
          .set({'habitName': namo, 'uid': Yuid, 'heatmap': {}});
    } catch (e) {
      print(e);
    }
  }

  double calculateHabitPercentages(arro) {
    int countCompleted = 0;
    for (int i = 0; i < arro.length; i++) {
      if (arro[i][1] == true) {
        countCompleted++;
      }
    }

    double percent = arro.isEmpty ? 0.0 : (countCompleted / arro.length);

    // key: "PERCENTAGE_SUMMARY_yyyymmdd"
    // value: string of 1dp number between 0.0-1.0 inclusive
    return percent;
  }

  void loadHeatMap() async {
    DateTime startDate = DateTime(3000, 12, 12);
    print(heatmap);
    heatmap.forEach((date, comp) {
      var theData = createDateTimeObject(date);
      if (theData.isBefore(startDate)) {
        startDate = theData;
      }
    });

    startdate.value = convertDateTimeToString(startDate);

    print(startdate);
    // count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to today and add each percentage to the dataset
    // "PERCENTAGE_SUMMARY_yyyymmdd" will be the key in the database
    for (int i = 0; i < daysInBetween + 1; i++) {
      double strengthAsPercent = 0.0;
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      if (heatmap.containsKey(yyyymmdd)) {
        List arroc = [];
        heatmap[yyyymmdd]!.forEach((key, value) {
          arroc.add([key, value]);
        });
        strengthAsPercent = calculateHabitPercentages(arroc);
      }

      // split the datetime up like below so it doesn't worry about hours/mins/secs etc.

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      // day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };
      print("heatmap is $percentForEachDay");

      heatMapDataSet.value.addEntries(percentForEachDay.entries);
    }
    print("heatmap is $heatMapDataSet");
    update();
  }
}
