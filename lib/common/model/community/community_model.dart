import 'package:habitomic_app/common/model/habit/habit_model.dart';
import 'package:habitomic_app/common/model/user/user_model.dart';

class CommunityModel {
  String? communityId;
  String? communityName;
  List<HabitModel>? habits;
  List<UserModel>? followers;
  int? rating;
  String? bio;
  String? imgUrl;

  CommunityModel({
    this.communityId,
    this.communityName,
    this.habits,
    this.followers,
    this.rating,
    this.bio,
    this.imgUrl,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
        communityName: json['communityName'],
        communityId: json['communityId'],
        habits: (json['habits'] as List<dynamic>?)
            ?.map((habitJson) => HabitModel.fromSnapshot(habitJson))
            .toList(),
        followers: (json['followers'] as List<dynamic>?)
            ?.map((followerJson) => UserModel.fromSnapshot(followerJson))
            .toList(),
        rating: json['rating'],
        bio: json['bio'],
        imgUrl: json['imgUrl']);
  }

  Map<String, dynamic> toJson() {
    return {
      'communityName': communityName,
      'communityId': communityId,
      'habits': habits?.map((habit) => habit.toJson()).toList(),
      'followers': followers?.map((follower) => follower.tojson()).toList(),
      'rating': rating,
      'bio': bio,
    };
  }
}
