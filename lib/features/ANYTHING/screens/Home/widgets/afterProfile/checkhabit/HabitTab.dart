// ignore: file_names
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/YallAuth.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/smallticker.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/timeline.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/comm_controller.dart';

class HabitTab extends StatefulWidget {
  final String commuid;
  const HabitTab({
    required this.commuid,
    super.key,
  });

  @override
  State<HabitTab> createState() => _HabitTabState();
}

List habitt = [];

class _HabitTabState extends State<HabitTab> {
  final CommunityController controller = Get.put(CommunityController());

  @override
  void initState() {
    super.initState();
    controller.updateCommId(widget.commuid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityController>(
        init: controller,
        builder: (controllero) {
          var here = controllero.todayHabit
              .where((element) => element[1] == false)
              .toList();
          print(here);
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: here.length,
              itemBuilder: (BuildContext context, int index) {
                var item = here[index];
                print(item);
                return Card(
                  child: CheckboxListTile(
                    title: Text(
                      item[2],
                      style: TextStyle(
                          decoration:
                              item[1] ? TextDecoration.lineThrough : null),
                    ),
                    value: item[1],
                    onChanged: (value) {
                      setState(() {
                        item[1] = value!;
                        controllero.pushtoFirebase(item[0], item[1]);
                      });
                    },
                  ),
                );
              },
            ),
          );
        });
  }
}

class commonHabitContainer extends StatefulWidget {
  final int weeks;
  final String weekName;
  final String habit1;
  final String habit2;
  final String habit3;

  const commonHabitContainer({
    super.key,
    required this.weekName,
    required this.widget,
    required this.habit1,
    required this.habit2,
    required this.habit3,
    required this.weeks,
  });

  final HabitTab widget;

  @override
  State<commonHabitContainer> createState() => _commonHabitContainerState();
}

class _commonHabitContainerState extends State<commonHabitContainer> {
  bool isclicked = false;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> modifiedList = [habitt[0]];

    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            ' Week ${widget.weeks}',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  timeline(
                    isfirst: false,
                    islast: false,
                    ispast: habitt[0][widget.weekName][0],
                  ),
                  timeline(
                    isfirst: false,
                    islast: false,
                    ispast: habitt[0][widget.weekName][1],
                  ),
                  timeline(
                    isfirst: false,
                    islast: false,
                    ispast: habitt[0][widget.weekName][2],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'key Weekly Habits',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            StatefulBuilder(
                              builder: (context, setState) {
                                return InkWell(
                                  onTap: () async {
                                    setState(() {
                                      modifiedList[0][widget.weekName][0] =
                                          !(modifiedList[0][widget.weekName]
                                              [0]);
                                    });

                                    print(
                                        '######################################################');
                                    print(modifiedList);
                                    await YAuth().updateAchivedHabits(
                                      whichIndex: 0,
                                      habitt: modifiedList,
                                      commUid: widget.widget.commuid,
                                      whichWeek: widget.weekName,
                                    );
                                  },
                                  child: smallDots(
                                    colors: habitt[0][widget.weekName][0]
                                        ? Colors.green
                                        : Colors.white,
                                    isdone: false,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.habit1,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  modifiedList[0][widget.weekName][1] =
                                      !(modifiedList[0][widget.weekName][1]);
                                });
                                print(
                                    '######################################################');
                                print(modifiedList);
                                await YAuth().updateAchivedHabits(
                                  whichIndex: 1,
                                  habitt: modifiedList,
                                  commUid: widget.widget.commuid,
                                  whichWeek: widget.weekName,
                                );
                              },
                              child: smallDots(
                                colors: habitt[0][widget.weekName][1]
                                    ? Colors.green
                                    : Colors.white,
                                isdone: false,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.habit2,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            StatefulBuilder(
                              builder: (context, setState) {
                                return InkWell(
                                  onTap: () async {
                                    setState(() {
                                      modifiedList[0][widget.weekName][2] =
                                          !(modifiedList[0][widget.weekName]
                                              [2]);
                                    });

                                    print(
                                        '######################################################');
                                    print(modifiedList);
                                    await YAuth().updateAchivedHabits(
                                      whichIndex: 2,
                                      habitt: modifiedList,
                                      commUid: widget.widget.commuid,
                                      whichWeek: widget.weekName,
                                    );
                                  },
                                  child: smallDots(
                                    colors: habitt[0][widget.weekName][2]
                                        ? Colors.green
                                        : Colors.white,
                                    isdone: false,
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.habit3,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  right: -1,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_border,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
