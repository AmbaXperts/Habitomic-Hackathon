import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/widgets/prof.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/profilePage/contacts.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/controller/profile_controller.dart';
import 'package:habitomic_app/features/personalization/screens/profile/profile.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  final String uid;

  const UserProfileScreen({
    super.key,
    required this.uid,
  });

  @override
  State<UserProfileScreen> createState() => _ProfileState();
}

class _ProfileState extends State<UserProfileScreen> {
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
                      isuserprofile: false,
                      username: controller.user['Username'],
                      fullname:
                          "${controller.user['FirstName'] + " " + controller.user['LastName']}",
                      date: DateFormat.yMMMd(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: cardWidget(
                        Icon(Icons.person),
                        'Profile',
                        'Manage your profile',
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: cardWidget(
                        const Icon(Icons.people_alt_outlined),
                        'Contacts',
                        'Find your partner',
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Contacts(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: cardWidget(
                        Icon(Icons.settings),
                        'Settings',
                        'Control your action',
                        () {},
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: cardWidget(
                        Icon(Icons.privacy_tip_rounded),
                        'Privacy',
                        'update and security',
                        () {},
                      ),
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
