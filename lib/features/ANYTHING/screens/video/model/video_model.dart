import 'package:cloud_firestore/cloud_firestore.dart';

class Video{
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videourl;
  String thumbnail;
  String profilePhoto;


  Video({
    required this.username,
     required this.uid,
      required this.id,
       required this.likes,
        required this.commentCount,
         required this.shareCount,
          required this.songName,
           required this.caption,
            required this.videourl,
             required this.profilePhoto,
              required this.thumbnail,
  });




  Map<String, dynamic> tojson() => {

    "username": username,
     "uid": uid,
      "profilePhoto": profilePhoto,
       "id": id,
        "likes": likes,
         "commentCount": commentCount,
          "shareCount": shareCount,
           "songName": songName,
            "caption": caption,
             "videourl": videourl,
              "thumbnail": thumbnail,
  };


  static Video fromSnap(DocumentSnapshot snap){
var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
      username: snapshot['username'],
       uid: snapshot['uid'],
        id: snapshot['id'],
         likes: snapshot['likes'],
          commentCount: snapshot['commentCount'],
           shareCount: snapshot['shareCount'],
            songName: snapshot['songName'],
             caption: snapshot['caption'],
              videourl: snapshot['videourl'],
              profilePhoto: snapshot['profilePhoto'],
              thumbnail: snapshot['thumbnail'],
    );
  }
}