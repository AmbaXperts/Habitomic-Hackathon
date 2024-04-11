import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/widgets/smallCircleIcon.dart';
import 'package:habitomic_app/features/personalization/controllers/user_controller.dart';

class ForYouScreen extends StatefulWidget {
  const ForYouScreen({super.key});

  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('post')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.greenAccent,
            ),
          );
        }
        return Container(
          height: 500,
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Exfeed(
                poostPhoto: snapshot.data!.docs[index]['PostphotoUrl'],
                discription: snapshot.data!.docs[index]['discription'],
                username: snapshot.data!.docs[index]['username'],
                photourl: snapshot.data!.docs[index]['UserphotoUrl'],
                index: index,
              );
            },
          ),
        );
      },
    );
  }
}

class Exfeed extends StatefulWidget {
  final String username;
  final String photourl;
  final String discription;
  final int index;
  final String poostPhoto;
  const Exfeed({
    super.key,
    required this.username,
    required this.discription,
    required this.photourl,
    required this.index,
    required this.poostPhoto,
  });

  @override
  State<Exfeed> createState() => _ExfeedState();
}

class _ExfeedState extends State<Exfeed> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        color: Colors.grey[100],
        height: 400,
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
                      backgroundImage: NetworkImage(
                        controller.user.value.profilePicture,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          controller.user.value.fullName.substring(0, 7),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '@${controller.user.value.fullName.substring(0, 7)}',
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
                Text(widget.discription),
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
                Container(
                  height: 150,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        widget.poostPhoto,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    smallCircleIcon(
                      onpressed: () {},
                      icons: Icon(
                        Icons.favorite,
                        size: 20,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.grey.shade400,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    smallCircleIcon(
                        onpressed: () {
                          //  Get.to(comment());
                        },
                        icons: Icon(
                          Icons.mode_comment_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.grey.shade400),
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
}
