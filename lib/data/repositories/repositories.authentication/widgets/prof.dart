import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/widget/fullscreen_show.dart';
import 'package:intl/intl.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/controller/profile_controller.dart';

class ProfileUtil extends StatefulWidget {
  final String username;
  final String fullname;
  final DateFormat date;
  final bool isuserprofile;

  ProfileUtil({
    Key? key,
    required this.username,
    required this.fullname,
    required this.date,
    required this.isuserprofile,
  }) : super(key: key);

  @override
  State<ProfileUtil> createState() => _ProfileUtilState();
}

class _ProfileUtilState extends State<ProfileUtil> {
  final ProfileController profileController = Get.find<ProfileController>();
  TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;

    return Obx(() => Container(
          decoration: BoxDecoration(
            color: brightness == Brightness.light ? Colors.white : const Color.fromARGB(255, 46, 46, 46),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          height: 380,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ImageFullScreenWrapperWidget(
                                      child: Image(
                                image: NetworkImage(
                                    profileController.user['ProfilePicture']),
                              )),
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              profileController.user['ProfilePicture'] ??
                                  'https://images.mubicdn.net/images/cast_member/286407/cache-139299-1463178721/image-w856.jpg?size=256x',
                            ),
                            radius: 40,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.fullname,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: brightness == Brightness.light ? Colors.black : Colors.white,
                            ),
                          ),
                          Text(
                            widget.username,
                            style: TextStyle(
                              fontSize: 20,
                              color: brightness == Brightness.light ? Colors.grey[500] : Colors.grey[400],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.av_timer_rounded),
                              Text(
                                'Member since ${widget.date.format(DateTime.now())}',
                              ),
                            ],
                          ),
                          widget.isuserprofile
                              ? profileController.user["isFollowing"]
                                  ? MaterialButton(
                                      height: 50,
                                      minWidth: 150,
                                      color: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        'Followed',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  : MaterialButton(
                                      height: 50,
                                      minWidth: 150,
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      onPressed: () =>
                                          profileController.followUser(),
                                      child: Text(
                                        'Follow',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                              : Container()
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Bio',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: brightness == Brightness.light ? Colors.black : Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BioDescription(),
                      ),
                    );
                  },
                  child: bioController.text.isEmpty
                      ? Text(
                          'No Bio',
                          style: TextStyle(
                            color: brightness == Brightness.light ? Colors.grey[400] : Colors.grey[300],
                          ),
                        )
                      : Text(
                          bioController.text,
                          style: TextStyle(
                            color: brightness == Brightness.light ? Colors.grey[400] : Colors.grey[300],
                          ),
                        ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    rowColumn('Community', '2'),
                    rowColumn('Habits', '3'),
                    rowColumn('Rating', "${profileController.user["rating"]}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          profileController.user['Following'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Following',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 30),
                    Column(
                      children: [
                        Text(
                          profileController.user['Follower'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Followers',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget rowColumn(String title, String howMuch) {
     Brightness brightness = Theme.of(context).brightness;
    return Row(
      children: [
        Column(
          children: [
            Icon(
              Icons.people_alt_outlined,
              size: 40,
            ),
            Text(
              title,
               style: TextStyle(
                            color: brightness == Brightness.light ? const Color.fromARGB(255, 31, 31, 31) : Colors.grey[300],
                          ),
            ),
            Text(howMuch,  style: TextStyle(
                            color: brightness == Brightness.light ? const Color.fromARGB(255, 31, 31, 31) : Colors.grey[300],
                          ),),
          ],
        ),
      ],
    );
  }
}

class BioDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController bioController = TextEditingController();

    Brightness brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.check,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: bioController,
                decoration: InputDecoration(
                  labelText: 'Bio',
                  labelStyle: TextStyle(
                    color: brightness == Brightness.light ? Colors.black : Colors.white,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: brightness == Brightness.light ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: brightness == Brightness.light ? Colors.black : Colors.white,
                ),
                onChanged: (value) {
                  bioController.text = value;
                },
              ),
              Text(
                'Write some description about yourself',
                style: TextStyle(
                  color: brightness == Brightness.light ? const Color.fromARGB(255, 46, 46, 46) : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
