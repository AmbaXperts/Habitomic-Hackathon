import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String description;
  String caption;
  String postUrl;
  String thumbnail;
  String profilePhoto;

  Post({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.description,
    required this.caption,
    required this.postUrl,
    required this.thumbnail,
    required this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "profilePhoto": profilePhoto,
    "id": id,
    "likes": likes,
    "commentCount": commentCount,
    "shareCount": shareCount,
    "description": description,
    "caption": caption,
    "postUrl": postUrl,
    "thumbnail": thumbnail,
  };

  static Post fromSnapshot(DocumentSnapshot snapshot) {
    var post = snapshot.data() as Map<String, dynamic>;

    return Post(
      username: post['username'],
      uid: post['uid'],
      id: post['id'],
      likes: post['likes'],
      commentCount: post['commentCount'],
      shareCount: post['shareCount'],
      description: post['description'],
      caption: post['caption'],
      postUrl: post['postUrl'],
      thumbnail: post['thumbnail'],
      profilePhoto: post['profilePhoto'],
    );
  }
}
