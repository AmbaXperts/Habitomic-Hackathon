import 'package:flutter/material.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/smallticker.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/timeline.dart';

class AchivedTab extends StatefulWidget {
  const AchivedTab({super.key});

  @override
  State<AchivedTab> createState() => _AchivedTabState();
}

class _AchivedTabState extends State<AchivedTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const Text(
                  'aug 23, 2020 ',
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
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'title',
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
                                  smallDots(
                                    colors: Colors.white,
                                    isdone: true,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Openings',
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
                                  smallDots(
                                    colors: Colors.white,
                                    isdone: true,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Openings',
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
                                  smallDots(
                                    colors: Colors.green,
                                    isdone: true,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Openings',
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
          ),
        ],
      ),
    );
  }
}
