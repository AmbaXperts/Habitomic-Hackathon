import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:date_picker_timeline/extra/color.dart';

import '/common/widgets/loader/ShimmerEffect.dart';
import '/features/personalization/controllers/user_controller.dart';
import '/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });
 @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    final bool isDark = brightnessValue == Brightness.dark;
    final controller = Get.put(UserController());
    List<String> days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
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
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.45,
      width: size.width,
      decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40))),
      child: Stack(
        children: [
          Positioned(
              top: 50,
              left: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Happy ${days[DateTime.now().weekday - 1]}!',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: isDark ? Colors.white : Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${DateTime.now().day} ${months[DateTime.now().month - 1].substring(0, 3)}. ${DateTime.now().year}, ${DateTime.now().hour}:${DateTime.now().minute}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100, color: isDark ? Colors.white : Colors.black),
                  ),
                ],
              )),
          Positioned(
            right: 20,
            top: 50,
            child: Container(
              width: 120,
              height: 70,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Obx(() {
                      if (controller.profileLoading.value) {
                        return const ShimmerEffect(width: 70, height: 70);
                      } else {
                        return Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      controller.user.value.profilePicture),
                                  fit: BoxFit.cover)),
                        );
                      }
                    }),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Obx(() {
                      if (controller.profileLoading.value) {
                        return const ShimmerEffect(width: 70, height: 70);
                      } else {
                        return Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 3, bottom: 5),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey,
                          ),
                          child: Text(
                            controller.user.value.firstName,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 30,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: size.width * 0.92,
                    height: 100,
                    decoration: BoxDecoration(
                        color: TColors.light,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        DatePicker(
                          DateTime.now(),
                          height: 100,
                          initialSelectedDate: DateTime.now(),
                          daysCount: 7,
                          selectionColor: Color(0xff996EFA),
                          selectedTextColor: Colors.white,
                          deactivatedColor: AppColors.defaultDeactivatedColor,
                          onDateChange: (date) {
                            // New date selected
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}