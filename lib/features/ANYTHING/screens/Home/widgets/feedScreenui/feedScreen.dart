import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/widgets/smallCircleIcon.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/feedScreenui/forYouFeedScreen.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/widget/view_post_screen.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/widget/feed_screen.dart';
import 'package:habitomic_app/features/personalization/controllers/user_controller.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with TickerProviderStateMixin {
  List<String?> FollowingUid = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    TabController tabController = TabController(
      length: 2,
      vsync: this,
    );
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: Colors.grey[200],
                expandedHeight: 150,
                flexibleSpace: ListView(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Feed  ',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  MaterialButton(
                                    height: 50,
                                    minWidth: 50,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: Color.fromARGB(255, 62, 70, 182),
                                    onPressed: () {},
                                    child: Icon(Icons.format_align_left_sharp),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 60),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Yared',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                        'https://www.thewall360.com/uploadImages/ExtImages/images1/def-638240706028967470.jpg',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                bottom: TabBar(
                  controller: tabController,
                  tabs: [
                    Tab(
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(
                            color: Colors.greenAccent,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text('For You'),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(
                            color: Colors.greenAccent,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text('Following'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //////////////////////////////
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: [
              PostScreen(),
              VideoScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class Exfeed extends StatefulWidget {
  final String username;
  final String photourl;
  final String discription;
  final int index;
  const Exfeed({
    super.key,
    required this.username,
    required this.discription,
    required this.photourl,
    required this.index,
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
        height: 310,
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
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '@${controller.user.value.fullName.substring(0, 7)}',
                          style: TextStyle(
                            fontSize: 17,
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
                        widget.photourl,
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
