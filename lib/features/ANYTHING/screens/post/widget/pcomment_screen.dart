import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/controller/comment_controllerP.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/controller/comment_controller.dart';

import 'package:timeago/timeago.dart' as tago;

class PCommentScreen extends StatelessWidget {
  final String id;
  PCommentScreen({Key? key, required this.id}) : super(key: key);

  final TextEditingController _pcommentController = TextEditingController();
  PCommentController pcommentController = Get.put(PCommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    pcommentController.updatePPostId(id);
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(child: Obx(() {
              return ListView.builder(
                  itemCount: pcommentController.pcomments.length,
                  itemBuilder: ((context, index) {
                    final cpcomment = pcommentController.pcomments[index];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: NetworkImage(cpcomment.profilePhoto),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "@${cpcomment.username} ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            tago.format(cpcomment.datePublished.toDate()),
                            style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 0, 0, 0)),
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
                                cpcomment.comment,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: const Color.fromARGB(255, 0, 0, 0),
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
                                  pcommentController.likePComment(cpcomment.id),
                              child: Icon(Icons.favorite,
                                  size: 25,
                                  color: cpcomment.likes.contains(
                                          AuthenticationRepository
                                              .instance.user.uid)
                                      ? Colors.red
                                      : const Color.fromARGB(255, 201, 201, 201))),
                          Text(
                            ' ${cpcomment.likes.length}',
                            style: const TextStyle(
                                fontSize: 12, color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    );
                  }));
            })),
            const Divider(),
            ListTile(
              title: TextFormField(
                controller: _pcommentController,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                decoration: const InputDecoration(
                    labelText: 'comment',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 132, 132, 132))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 168, 168, 168),
                    ))),
              ),
              trailing: TextButton(
                onPressed: () =>
                    pcommentController.PpostComment(_pcommentController.text),
                child: const Text(
                  'send',
                  style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
