import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/YallAuth.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/smallticker.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/checkhabit/timeline.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/comm_controller.dart';

class AchievedTab extends StatefulWidget {
  final String commuid;
  const AchievedTab({
    required this.commuid,
    super.key,
  });

  @override
  State<AchievedTab> createState() => _AchievedState();
}

List habitt = [];

class _AchievedState extends State<AchievedTab> {
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
              .where((element) => element[1] == true)
              .toList();
          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: here.length,
              itemBuilder: (BuildContext context, int index) {
                var item = here[index];
                return Text(
                  item[2],
                  style: TextStyle(
                      decoration: item[1] ? TextDecoration.lineThrough : null),
                );
              },
            ),
          );
        });
  }
}
