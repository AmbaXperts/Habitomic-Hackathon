import 'package:cloud_firestore/cloud_firestore.dart';

class HabitModel {
  String? habitId;
  String? habitName;
 

  HabitModel({this.habitId, this.habitName});
  factory HabitModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return HabitModel(
      habitId: snapshot["habitId"],
      habitName: snapshot["habitName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "habitId" : habitId,
      "habitName" : habitName,
    };
  }
}
