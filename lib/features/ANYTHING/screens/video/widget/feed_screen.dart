import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/comment_screen.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/controller/video_controller.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/widget/circle_animation.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/widget/search_screen.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/widget/video_player_item.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatelessWidget {
   VideoScreen({Key? key}): super(key: key);

  final VideoController videoController = Get.put(VideoController());
  buildProfile(String profilePhoto, bool isDark) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image(
                    image: NetworkImage(profilePhoto),
                    fit: BoxFit.cover,
                  )),
            ),
          )
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto, bool isDark) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(11),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                gradient:
                    const LinearGradient(colors: [Colors.grey, Colors.white]
                    ),
                    borderRadius: BorderRadius.circular(25),
                    ),
                    child: ClipRRect(borderRadius: BorderRadius.circular(25),
                    child: Image(image: NetworkImage(profilePhoto), fit: BoxFit.cover,),
                    ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    final bool isDark = brightnessValue == Brightness.dark;

    return Scaffold(
      body: Obx(
        
         () {
          return PageView.builder(
             itemCount:videoController.videoList.length ,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final data=videoController.videoList[index];
              return Stack(
                children: [
                  VideoPlayerItem( videoUrl:data.videourl), 
                  Column(
                    children: [
                      const SizedBox(height: 100),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      data.username,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: isDark ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      data.caption,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: isDark ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.music_note,
                                            size: 15, color: Colors.white),
                                        Text(
                                          data.songName,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: isDark ? Colors.white : Colors.black,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(top: size.height / 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildProfile(data.profilePhoto, isDark),
                                  Column(
                                    children: [
                                      InkWell(
                                          onTap: () => videoController.likeVideo(data.id),
                                          child: Icon(
                                            Icons.favorite,
                                            size: 40,
                                            color:data.likes.contains(AuthenticationRepository.instance.user.uid) ?  Color.fromARGB(255, 241, 4, 4): Colors.white,
                                          )),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        data.likes.length.toString(),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CommentScreen(id: data.id))),
                                          child: Icon(
                                            Icons.comment,
                                            size: 40,
                                            color: isDark ? Colors.white : Colors.black,
                                          )),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        data.commentCount.toString(),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                       InkWell(
                                         onTap: () {
            // Navigate to another screen when the search icon is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ),
            );
          },
                                          child: Icon(
                                            Icons.search,
                                            size: 40,
                                            color: Colors.white,
                                          )),
                                      InkWell(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.reply,
                                            size: 40,
                                            color: Colors.white,
                                          )),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                       data.shareCount.toString(),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )
                                    ],
                                  ),
                                  CircleAnimation(
                                    child: buildMusicAlbum(data.profilePhoto, isDark),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
          );
        }
      ),
    );
  }
}