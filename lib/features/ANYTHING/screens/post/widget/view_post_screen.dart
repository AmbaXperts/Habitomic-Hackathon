import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/widgets/smallCircleIcon.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/controller/post_controller.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/model/post_model.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/widget/fullscreen_show.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/widget/pcomment_screen.dart';

class PostScreen extends StatelessWidget {
  final PostController _postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    final bool isDark = brightnessValue == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Obx(
        () {
          if (_postController.postList.isEmpty) {
            if (_postController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (_postController.error.isNotEmpty) {
              return Center(
                child: Text('Error: ${_postController.error.value}'),
              );
            } else {
              return Center(
                child: Text('No posts available.'),
              );
            }
          } else {
            return ListView.builder(
              itemCount: _postController.postList.length,
              itemBuilder: (context, index) {
                final data = _postController.postList[index];
                return _buildPostItem(context, data, isDark);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildPostItem(BuildContext context, Post post, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        height: 350,
        margin: EdgeInsets.all(6),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(post.profilePhoto),
                    ),
                    Column(
                      children: [
                        Text(
                          post.username,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          '@${post.username}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Text('  2hr ago'),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert_outlined,
                        size: 30,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(post.description),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'more',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 150,
                  width: 2,
                  color: Colors.black54,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return ImageFullScreenWrapperWidget(
                        child: Image(
                      image: NetworkImage(post.postUrl),
                    ));
                  })),
                  child: Container(
                    height: 150,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          post.postUrl,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => _postController.likePost(post.id),
                      child: Icon(
                        Icons.favorite,
                        size: 40,
                        color: post.likes.contains(
                                AuthenticationRepository.instance.user.uid)
                            ? Color.fromARGB(255, 241, 4, 4)
                            : isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      post.likes.length.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white : Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () => _onCommentTap(context, post.id),
                      child: Icon(
                        Icons.comment,
                        size: 40,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      post.commentCount.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white : Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    smallCircleIcon(
                        onpressed: () {},
                        icons: Icon(
                          Icons.bookmark_add_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.grey.shade400),
                  ],
                ),
              ],
            ),
            Container(
              height: 5,
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }

  void _onCommentTap(BuildContext context, String postId) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PCommentScreen(id: postId),
    ));
  }
}