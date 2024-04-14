import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/common/widgets/loader/ShimmerEffect.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/widgets/smallCircleIcon.dart';

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
    final brightness = Theme.of(context).brightness;

    final controller = Get.put(UserController());
    TabController tabController = TabController(
      length: 2,
      vsync: this,
    );
    print(brightness);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor:  brightness == Brightness.light ? Colors.white :  const Color.fromARGB(255, 56, 56, 56) ,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,

                backgroundColor:brightness == Brightness.light ? Colors.white :  const Color.fromARGB(255, 56, 56, 56) ,

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

                            color: brightness == Brightness.light ? Colors.white :  const Color.fromARGB(255, 56, 56, 56) ,

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
                                      color: brightness == Brightness.light
                                          ? const Color.fromARGB(
                                              255, 56, 56, 56)
                                          : Colors.white,
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
                              Positioned(
                                right: 20,
                                top: 50,
                                child: Container(
                                  width: 120,
                                  height: 70,
                                  color: brightness == Brightness.light ? Colors.white :  const Color.fromARGB(255, 56, 56, 56) ,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Obx(() {
                                          if (controller.profileLoading.value) {
                                            return const ShimmerEffect(
                                                width: 70, height: 70);
                                          } else {
                                            return Container(
                                              width: 70,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          controller.user.value
                                                              .profilePicture),
                                                      fit: BoxFit.cover)),
                                            );
                                          }
                                        }),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Obx(() {
                                          if (controller.profileLoading.value) {
                                            return const ShimmerEffect(
                                                width: 70, height: 70);
                                          } else {
                                            return Container(
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 3,
                                                  bottom: 5),
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.blueGrey,
                                              ),
                                              child: Text(
                                                controller.user.value.firstName,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            );
                                          }
                                        }),
                                      ),
                                    ],
                                  ),
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

                          color: brightness == Brightness.light ? Colors.white :  const Color.fromARGB(255, 56, 56, 56) ,

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

                          color: brightness == Brightness.light ? Colors.white :  const Color.fromARGB(255, 56, 56, 56) ,

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
    Key? key,
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
    final brightness = Theme.of(context).brightness;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        color: brightness == Brightness.light
            ? Colors.grey[100]
            : Colors.grey[900],
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
                            color: brightness == Brightness.light
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                        Text(
                          '@${controller.user.value.fullName.substring(0, 7)}',
                          style: TextStyle(
                            fontSize: 17,
                            color: brightness == Brightness.light
                                ? Colors.grey[500]
                                : Colors.grey[400],
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
                        color: brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
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
                Text(
                  widget.discription,
                  style: TextStyle(
                    color: brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'more',
                    style: TextStyle(
                      color: brightness == Brightness.light
                          ? Colors.blue
                          : Colors.lightBlueAccent,
                    ),
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
