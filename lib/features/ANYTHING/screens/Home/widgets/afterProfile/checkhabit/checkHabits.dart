import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/AllCommunityPaages/widget/text.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/AllCommunityPaages/widget/textForm.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/HabitResources.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/HabitTab.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/achivedHabitsTab.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/comm_controller.dart';
import 'package:habitomic_app/utils/popups/loaders.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CheckHabits extends StatefulWidget {
  final Timestamp? stamp;
  final String commUid;
  final int rating;
  final String commName;
  final String commPhotoUrl;
  const CheckHabits({
    super.key,
    required this.rating,
    required this.stamp,
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
  final CommunityController controllero = Get.put(CommunityController());
  List<String> months = <String>[
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
    TextEditingController createHabController = TextEditingController();
    TabController controller = TabController(
      length: 2,
      vsync: this,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                  right: 10,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    text(HeadName: 'New Habit'),
                    const SizedBox(
                      height: 15,
                    ),
                    YTextForm(
                      controller: createHabController,
                      lableText: ' Write Habit 1',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 50,
                          minWidth: 50,
                          color: Colors.blueAccent,
                          onPressed: () {
                            if (createHabController.text == "") {
                              Loader.errorSnackBar(
                                  title: "Add the necessary fields with datas");
                            } else {
                              setState(
                                () {
                                  controllero.addDataToFireStore(
                                      createHabController.text);
                                  Loader.successSnackBar(
                                      title: "Added",
                                      message: "new habit added for next day");
                                },
                              );
                              createHabController.text = "";
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text(
                            ' Finish',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ));
            },
          );
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
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
                                            'Dailies',
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
                indicatorWeight: 6,
                indicatorColor: Colors.purple,
                unselectedLabelStyle: TextStyle(color: Colors.grey),
                labelColor: Colors.black,
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
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Habits',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  Tab(
                    icon: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Achieved',
                            style: TextStyle(fontWeight: FontWeight.w600)),
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
            ),
            AchievedTab(
              commuid: widget.commUid,
            ),
          ],
        ),
      ),
    );
  }
}
