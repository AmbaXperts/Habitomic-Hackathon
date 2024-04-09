import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/controller/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;
class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({Key? key, required this.id}) : super(key: key);

  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id); // Update the postId in the controller
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(child: Obx(() {
              return ListView.builder(
                  itemCount: commentController.comments.length,
                  itemBuilder: ((context, index) {
                    final ccomment = commentController.comments[index];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: NetworkImage(ccomment.profilePhoto),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "@${ccomment.username} ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            tago.format(ccomment.datePublished.toDate()),
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Text(
                                ccomment.comment,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Column(
                        children: [
                          InkWell(
                              onTap: () =>
                                  commentController.likeComment(ccomment.id),
                              child: Icon(Icons.favorite,
                                  size: 25,
                                  color: ccomment.likes.contains(
                                          AuthenticationRepository
                                              .instance.user.uid)
                                      ? Colors.red
                                      : Colors.white)),
                          Text(
                            ' ${ccomment.likes.length}',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }));
            })),
            const Divider(),
            ListTile(
              title: TextFormField(
                controller: _commentController,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                    labelText: 'comment',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.red,
                    ))),
              ),
              trailing: TextButton(
                onPressed: () =>
                    commentController.postComment(_commentController.text),
                child: const Text(
                  'send',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
