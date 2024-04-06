import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/widgets/prof.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/profilePage/contacts.dart';
import 'package:intl/intl.dart';

class userProfileScreen extends StatefulWidget {
  const userProfileScreen({
    super.key,
  });

  @override
  State<userProfileScreen> createState() => _ProfileState();
}

class _ProfileState extends State<userProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                ProfileUtil(
                  isuserprofile: true,
                  username: '@yared',
                  fullname: 'yared',
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
                    () {},
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
