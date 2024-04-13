import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/widgets/prof.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/profilePage/contacts.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/controller/profile_controller.dart';
import 'package:intl/intl.dart';

class OtherUserProfile extends StatefulWidget {
  final String uid;

  const OtherUserProfile({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<OtherUserProfile> createState() => _OtherProfile();
}

class _OtherProfile extends State<OtherUserProfile> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: SafeArea(
            child: ListView(
              children: [
                Column(
                  children: [
                    ProfileUtil(
                      isuserprofile: true,
                      username: controller.user['Username'],
                      fullname:
                          "${controller.user['FirstName']} ${controller.user['LastName']}",
                      date: DateFormat.yMMMd(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Card cardWidget(
    Icon icons,
    String title,
    String subtitle,
    VoidCallback? onpressed,
  ) {
    return Card(
      child: ListTile(
        leading: icons,
        title: Center(
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Center(child: Text(subtitle)),
        trailing: IconButton(
          onPressed: onpressed,
          icon: Icon(
            Icons.arrow_forward_ios,
          ),
        ),
      ),
    );
  }
}
