import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/HabitResources.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/HabitTab.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/achivedHabitsTab.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CheckHabits extends StatefulWidget {
  final Timestamp? stamp;
  final String commUid;
  final int rating;
  final String commName;
  final String commPhotoUrl;
  final List habits;
  const CheckHabits({
    super.key,
    required this.rating,
    required this.stamp,
    required this.habits,
    required this.commUid,
    required this.commName,
    required this.commPhotoUrl,
  });

  @override
  State<CheckHabits> createState() => _CheckHabitsState();
}

class _CheckHabitsState extends State<CheckHabits>
    with TickerProviderStateMixin {
  ProgressIndicator? progressIndicator;

  // List<SingleState> allStages = [
  //   SingleState(stateTitle: "Stage 1"),
  //   SingleState(stateTitle: "Stage 2"),
  //   SingleState(stateTitle: "Stage 3"),
  //   SingleState(stateTitle: "Stage 4"),
  // ];
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  @override
  Widget build(BuildContext context) {
    TabController controller = TabController(
      length: 3,
      vsync: this,
    );

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              expandedHeight: 210,
              flexibleSpace: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      size: 30,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // DropdownButton(
                                      //   items: [
                                      //   DropdownMenuItem(child: child)
                                      //   ],
                                      // );
                                    },
                                    icon: Icon(
                                      Icons.more_vert,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                      widget.commPhotoUrl,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Text(
                                          widget.commName,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Icon(
                                            Icons.timer,
                                            color: Colors.grey[500],
                                          ),
                                          Text(
                                            'members since ${months[widget.stamp!.toDate().month - 1]} ${widget.stamp!.toDate().year - 1} ',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                        child: Text('Habits'),
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
                        child: Text('Achieved'),
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
                        child: Text('Resources'),
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
            HabitTab(
              commuid: widget.commUid,
              habits: widget.habits,
            ),
            AchivedTab(
              rating: widget.rating,
              commuid: widget.commUid,
              habits: widget.habits,
            ),
            Resources(),
          ],
        ),
      ),
    );
  }
}
