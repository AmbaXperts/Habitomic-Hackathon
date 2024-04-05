import 'package:flutter/material.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/widgets/prof.dart';
import 'package:intl/intl.dart';

class otherPeopleProfile extends StatefulWidget {
  const otherPeopleProfile({super.key});

  @override
  State<otherPeopleProfile> createState() => _otherPeopleProfileState();
}

class _otherPeopleProfileState extends State<otherPeopleProfile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Column(
                children: [
                  ProfileUtil(
                    username: '@yared',
                    fullname: 'yared dereje',
                    date: DateFormat.yMMM(),
                    isuserprofile: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TabBar(
                    onTap: (value) {},
                    unselectedLabelColor: Colors.grey[400],
                    tabAlignment: TabAlignment.center,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: Text(
                          'Posts',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Habits',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Communities',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
