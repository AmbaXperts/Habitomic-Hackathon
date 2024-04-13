import 'package:flutter/material.dart';

class THomeBody extends StatelessWidget {
  const THomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    final bool isDark = brightnessValue == Brightness.dark;

    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(17),
      height: size.height * 0.47,
      width: size.width,
      color: isDark ? Colors.grey[900] : Color(0xffF6F7FB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Habits',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: isDark ? Colors.white : Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 70,
                width: 70,
                padding: EdgeInsets.all(7),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color(0xff996EFA),
                    borderRadius: BorderRadius.circular(15)),
                child: Icon(
                  Icons.directions_run_rounded,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Recent Activities',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: isDark ? Colors.white : Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Container(
                width: size.width * 0.88,
                height: 80,
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: Color(0xff996EFA),
                          borderRadius: BorderRadius.circular(15)),
                      child: Icon(
                        Icons.directions_run_rounded,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Achieved Running Habit",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black),
                        ),
                        Text(
                          "From Sports Club",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400, color: isDark ? Colors.white : Colors.black),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}