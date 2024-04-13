import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/YallAuth.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/widgets/smallCircleIcon.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/AllCommunityPaages/community/communitySearch.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/AllCommunityPaages/community/leaderboard.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/checkHabits.dart';
import 'package:habitomic_app/features/personalization/controllers/user_controller.dart';

class joinCommunity extends StatefulWidget {
  final String comPicture;
  final List like;
  final String comname;
  final String comBio;
  final List comMembers;
  final List comHabits;
  final int rating;
  final String uuid;
  const joinCommunity({
    super.key,
    required this.like,
    required this.comBio,
    required this.comHabits,
    required this.comMembers,
    required this.comPicture,
    required this.comname,
    required this.rating,
    required this.uuid,
  });

  @override
  State<joinCommunity> createState() => _joinCommunityState();
}

class _joinCommunityState extends State<joinCommunity>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    bool isproccess = false;

    TabController controller = TabController(
      length: 2,
      vsync: this,
    );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
          ),
          actions: [
            StatefulBuilder(
              builder: (context, setState) {
                bool islike = widget.like
                    .contains(FirebaseAuth.instance.currentUser!.uid);
                bool like = false;
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ClipOval(
                    child: Material(
                      color: Colors.grey,
                      child: IconButton(
                        onPressed: () async {
                          String res = await YAuth().likeCommunity(
                            commUid: widget.uuid,
                            commLikes: widget.like,
                            likeUserId: FirebaseAuth.instance.currentUser!.uid,
                          );

                          setState(
                            () {
                              like = true;
                              islike = widget.like.contains(
                                  FirebaseAuth.instance.currentUser!.uid);
                            },
                          );
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: widget.like.contains(
                                      FirebaseAuth.instance.currentUser!.uid) ||
                                  islike ||
                                  like
                              ? Colors.red
                              : Colors.grey[200],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: Colors.grey[200],
                expandedHeight: 380,
                flexibleSpace: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            List members = widget.comMembers;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                        widget.comPicture,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          widget.comname,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.star_border_outlined,
                                              ),
                                            ),
                                            Text(
                                              '${widget.rating} Rating',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Bio',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  widget.comBio,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.people_outline_rounded,
                                        ),
                                        Text(
                                          '${widget.comMembers.length} Members',
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.people_outline_rounded,
                                        ),
                                        Text(
                                          '${widget.comHabits.length} Habits',
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.people_outline_rounded,
                                        ),
                                        Text(
                                          '${widget.like.length} Likes',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                !widget.comMembers.any((element) =>
                                        element['userId'] ==
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            color: Color.fromARGB(
                                                255, 139, 87, 148),
                                            height: 50,
                                            minWidth: 200,
                                            onPressed: () async {
                                              setState(() {
                                                isproccess = true;
                                              });
                                              DateTime now = DateTime.now();
                                              Timestamp timestamp =
                                                  Timestamp.fromDate(now);
                                              setState(
                                                () {
                                                  members.add(
                                                    {
                                                      'userId': FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid,
                                                      'date': timestamp,
                                                    },
                                                  );
                                                },
                                              );
                                              String res = await YAuth()
                                                  .joinUserToCommunity(
                                                members: members,
                                                uuid: widget.uuid,
                                              );
                                              print(
                                                  '444444444444444444444444444');
                                              print(res);

                                              setState(() {
                                                isproccess = false;
                                                print(members);
                                              });
                                              // Get.snackbar(
                                              //   snackPosition:
                                              //       SnackPosition.BOTTOM,
                                              //   '',
                                              //   'Congratulation! you successfully joined ${widget.comname} community. you can check the habits by clicking the check habit in the community .',
                                              //   borderRadius: 15,
                                              //   backgroundGradient:
                                              //       const LinearGradient(
                                              //     colors: [
                                              //       Colors.blue,
                                              //       Colors.black,
                                              //     ],
                                              //   ),
                                              // );
                                              // Navigator.of(context).push(
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         commSearch(),
                                              //   ),
                                              // );
                                            },
                                            child: !isproccess
                                                ? Center(
                                                    child: Text(
                                                      'Join Now',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    width: 30,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                  ),
                                          ),
                                          ClipOval(
                                            child: Material(
                                              color: Colors.grey,
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.share,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            color: const Color.fromARGB(
                                                255, 155, 85, 168),
                                            height: 50,
                                            minWidth: 200,
                                            onPressed: () async {
                                              Timestamp? stamp;
                                              for (int i = 0;
                                                  i < widget.comMembers.length;
                                                  i++) {
                                                if (widget.comMembers[i]
                                                        ['userId'] ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid) {
                                                  setState(() {
                                                    stamp = widget.comMembers[i]
                                                        ['date'];
                                                  });
                                                }
                                              }
                                              print(
                                                  '###########################################');
                                              print(stamp);
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CheckHabits(
                                                    rating: widget.rating,
                                                    commUid: widget.uuid,
                                                    stamp: stamp,
                                                    habits: widget.comHabits,
                                                    commName: widget.comname,
                                                    commPhotoUrl:
                                                        widget.comPicture,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Center(
                                              child: Text('Check Habits'),
                                            ),
                                          ),
                                          ClipOval(
                                            child: Material(
                                              color: Colors.yellow,
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        LeaderBoard(),
                                                  ));
                                                },
                                                icon: Icon(
                                                  Icons.kitesurfing_outlined,
                                                ),
                                              ),
                                            ),
                                          ),
                                          ClipOval(
                                            child: Material(
                                              color: Colors.grey,
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.share,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                bottom: TabBar(
                  unselectedLabelStyle: TextStyle(color: Colors.grey),
                  labelColor: Colors.green,
                  overlayColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 187, 151, 193),
                  ),
                  controller: controller,
                  tabs: [
                    Tab(
                      icon: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.green,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Feed'),
                        ),
                      ),
                    ),
                    Tab(
                      icon: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.green,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Habits'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: controller,
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('post')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Exfeed(
                        username: snapshot.data!.docs[index]['username'],
                        discription: snapshot.data!.docs[index]['discription'],
                        postphotourl: snapshot.data!.docs[index]
                            ['PostphotoUrl'],
                        index: index,
                      );
                    },
                  );
                },
              ),
              Container(
                color: Colors.blue,
                height: 600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//for the feed part

class Exfeed extends StatefulWidget {
  final String username;
  final String postphotourl;
  final String discription;
  final int index;
  const Exfeed({
    super.key,
    required this.username,
    required this.discription,
    required this.postphotourl,
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
                  child: Image(
                    image: NetworkImage(
                      widget.postphotourl,
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
