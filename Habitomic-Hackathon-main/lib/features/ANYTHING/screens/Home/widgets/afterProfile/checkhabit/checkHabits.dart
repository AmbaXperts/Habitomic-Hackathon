import 'package:flutter/material.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/HabitResources.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/HabitTab.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/achivedHabitsTab.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CheckHabits extends StatefulWidget {
  const CheckHabits({super.key});

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
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.arrow_back,
                                      size: 30,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.more_vert,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                      'data:image/jpeg;base64,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',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Chess Community',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Icon(
                                            Icons.timer,
                                          ),
                                          Text(
                                            'members since aug 2023',
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
            HabitTab(),
            AchivedTab(),
            Resources(),
          ],
        ),
      ),
    );
  }
}
