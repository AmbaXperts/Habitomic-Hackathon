import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/controller/post_controller.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/model/post_model.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/widget/pcomment_screen.dart';


class PostScreen extends StatelessWidget {
  final PostController _postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
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
                return _buildPostItem(context, data);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildPostItem(BuildContext context, Post post) {
    
    return Card(
      
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.profilePhoto),
            ),
            title: Text(post.username),
            subtitle: Text(post.description),
          ),
          post.postUrl.isNotEmpty
              ? Image.network(post.postUrl)
              : Container(), // Display image if available
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Column(
                   children: [
                     InkWell(
                      onTap: () =>
                          _postController.likePost(post.id),
                      child: Icon(
                        Icons.favorite,
                        size: 40,
                        color: post.likes.contains(
                                AuthenticationRepository.instance.user.uid)
                            ? Color.fromARGB(255, 241, 4, 4)
                            : Colors.white,
                      ),
                                     ),
                     Text(
                                            post.likes.length.toString(),
                                            style: TextStyle(
                                                fontSize: 12, color: Colors.white),
                                          ),
                   ],
                 ),
                Column(
                  children: [
                    InkWell(
                      onTap: () => _onCommentTap(context, post.id),
                      child: Icon(
                        Icons.comment,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    
                    Text(
                                        post.commentCount.toString(),
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      )
                  ],
                ),
                
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    // Handle share functionality here
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onCommentTap(BuildContext context, String postId) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PCommentScreen(id: postId),
    ));
  }
}
