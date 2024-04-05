import 'package:habitomic_app/common/model/habit/habit_model.dart';
import 'package:habitomic_app/common/model/user/user_model.dart';

class CommunityModel {
  String? communityId;
  List<HabitModel>? habits;
  List<UserModel>? followers;
  int? rating;
  String? bio;

  CommunityModel({this.communityId, this.habits, this.followers, this.rating, this.bio});

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      communityId: json['communityId'],
      habits: (json['habits'] as List<dynamic>?)
          ?.map((habitJson) => HabitModel.fromSnapshot(habitJson))
          .toList(),
      followers: (json['followers'] as List<dynamic>?)
          ?.map((followerJson) => UserModel.fromSnapshot(followerJson))
          .toList(),
      rating: json['rating'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'communityId': communityId,
      'habits': habits?.map((habit) => habit.toJson()).toList(),
      'followers': followers?.map((follower) => follower.tojson()).toList(),
      'rating': rating,
      'bio': bio,
    };
  }
}
