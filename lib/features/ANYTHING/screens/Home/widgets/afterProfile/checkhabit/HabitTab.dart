// ignore: file_names
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/YallAuth.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/smallticker.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/timeline.dart';

class HabitTab extends StatefulWidget {
  final List habits;
  final String commuid;
  const HabitTab({
    required this.habits,
    required this.commuid,
    super.key,
  });

  @override
  State<HabitTab> createState() => _HabitTabState();
}

List habitt = [];

class _HabitTabState extends State<HabitTab> {
  @override
  void initState() {
    super.initState();
    getAchivedHabit();
  }

  getAchivedHabit() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('Ycommunity')
        .doc(widget.commuid)
        .collection('achievedHabits')
        .doc(
          FirebaseAuth.instance.currentUser!.uid,
        )
        .get();
    setState(() {
      habitt = (snap.data() as Map<String, dynamic>)['habitt'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Column(
            children: [
              commonHabitContainer(
                widget: widget,
                weeks: 1,
                weekName: 'week1',
                habit1: widget.habits[0]['week1'][0],
                habit2: widget.habits[0]['week1'][1],
                habit3: widget.habits[0]['week1'][2],
              ),
              const SizedBox(
                height: 10,
              ),
              commonHabitContainer(
                widget: widget,
                weeks: 2,
                weekName: 'week2',
                habit1: widget.habits[0]['week2'][0],
                habit2: widget.habits[0]['week2'][1],
                habit3: widget.habits[0]['week2'][2],
              ),
              const SizedBox(
                height: 10,
              ),
              commonHabitContainer(
                widget: widget,
                weekName: 'week3',
                weeks: 3,
                habit1: widget.habits[0]['week3'][0],
                habit2: widget.habits[0]['week3'][1],
                habit3: widget.habits[0]['week3'][2],
              ),
              const SizedBox(
                height: 10,
              ),
              commonHabitContainer(
                widget: widget,
                weeks: 4,
                weekName: 'week4',
                habit1: widget.habits[0]['week4'][0],
                habit2: widget.habits[0]['week4'][1],
                habit3: widget.habits[0]['week4'][2],
              ),
            ],
          )
        ],
      ),
    );
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
  @override
  Widget build(BuildContext context) {
    bool boo = false;
    Map<String, dynamic> modifiedList = {
      'week1': [false, false, false],
      'week2': [false, false, false],
      'week3': [false, false, false],
      'week4': [false, false, false],
    };

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
          const SizedBox(
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
                    ispast: true,
                  ),
                  timeline(
                    isfirst: false,
                    islast: false,
                    ispast: true,
                  ),
                  timeline(
                    isfirst: false,
                    islast: false,
                    ispast: false,
                  ),
                  timeline(
                    isfirst: false,
                    islast: true,
                    ispast: false,
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
                            GestureDetector(
                              onTap: () async {
                                modifiedList[widget.weekName][0] =
                                    !(modifiedList[widget.weekName][0]);
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
                                colors: modifiedList[widget.weekName][0]
                                    ? Colors.green
                                    : Colors.white,
                                isdone: false,
                              ),
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
                            GestureDetector(
                              onTap: () async {
                                modifiedList[widget.weekName][1] =
                                    !(modifiedList[widget.weekName][1]);
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
                                colors: modifiedList[widget.weekName][0]
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
                            GestureDetector(
                              onTap: () async {
                                modifiedList[widget.weekName][2] =
                                    !(modifiedList[widget.weekName][2]);

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
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return habitt[0][widget.weekName][0]
                                      ? Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        )
                                      : Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        );
                                },
                              ),
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
