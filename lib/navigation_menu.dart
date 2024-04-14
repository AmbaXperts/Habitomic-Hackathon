import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/AllCommunityPaages/community/createComm.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/AllCommunityPaages/community/communitySearch.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/feedScreenui/feedScreen.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/postPage/postscreen.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/profilePage/userProfilePage.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/add_post.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/widget/view_post_screen.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/add_video_screen.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/widget/feed_screen.dart';
import 'package:habitomic_app/features/personalization/screens/settings/settings.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import '/features/ANYTHING/screens/Home/widgets/home.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({Key? key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final pages = [
    const HomeScreen(),
    const commSearch(),
    const AddPostScreen(),
    const Feed(),
    UserProfileScreen(uid: AuthenticationRepository.instance.user.uid),
  ];
  int page = 0;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    final bool isDark = brightnessValue == Brightness.dark;
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: ConvexAppBar(
        height: 80,
        elevation: 0,
        initialActiveIndex: 0,
        style: TabStyle.fixedCircle,
        color: Colors.grey,
        backgroundColor: isDark ? Colors.black26 : Colors.white,
        activeColor: const Color(0xffFFBD59),
        items: [
          TabItem(icon: Icons.home, title: 'Today'),
          TabItem(icon: Icons.people_alt_sharp, title: 'Lobby'),
          TabItem(icon: Icons.add, title: ''),
          TabItem(icon: Icons.feed, title: 'Feed'),
          TabItem(icon: Icons.person_2, title: 'Profile'),
        ],
        onTap: (index) {
          if (index == 2) {
            setState(() {
              isExpanded = !isExpanded;
            });
          } else {
            setState(() {
              page = index;
            });
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: isExpanded ? 150 : 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                heroTag: 1,
                onPressed: () {
                  Get.to(const AddPostScreen());
                },
                tooltip: 'Add Post',
                child: Icon(Icons.add,
                    color: !isExpanded
                        ? isDark
                            ? Colors.black26
                            : Colors.white
                        : !isDark
                            ? Colors.black26
                            : Colors.white),
              ),
              SizedBox(
                width: 40,
              ),
              FloatingActionButton(
                onPressed: () {
                  Get.to(const AddVideoScreen());
                },
                tooltip: 'Add Video',
                child: Icon(
                  Icons.video_camera_back,
                  color: !isExpanded
                      ? isDark
                          ? Colors.black26
                          : Colors.white
                      : !isDark
                          ? Colors.black26
                          : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// class NavigationMenu extends StatelessWidget {
//   const NavigationMenu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(NavigationController());
//     final darkMode = THelperFunctions.isDarkMode(context);

//     return Scaffold(
//       bottomNavigationBar: Obx(
//         () => ConvexAppBar(
//           height: 80,
//           elevation: 0,
//           initialActiveIndex: 0,
//           style: TabStyle.fixedCircle,
//           color: Colors.grey,
//           backgroundColor: Colors.white,
//           activeColor: Color(0xffFFBD59),
//           items: [
//             TabItem(icon: Icons.home, title: 'Today'),
//             TabItem(icon: Icons.people_alt_sharp, title: 'Community'),
//             TabItem(icon: Icons.add, title: ''),
//             TabItem(icon: Icons.feed, title: 'Feed'),
//             TabItem(icon: Icons.person_2, title: 'Profile'),
//           ],
//           onTap: (index) => controller.selectedIndex.value = index,
//         ),
//       ),
//       body: Obx(() => controller.screens[controller.selectedIndex.value]),
//     );
//   }
// }

// class NavigationController extends GetxController {
//   final Rx<int> selectedIndex = 0.obs;
//   final screens = [
//     const PostData(),
//     const Feed(),
//     const CreateCommunity(),
//     const SettingScreen(),
//   ];
// }


// ConvexAppBar(
//           height: 80,
//           elevation: 0,
//           initialActiveIndex: 2,
//           style: TabStyle.fixedCircle,
//           color: Colors.grey,
//           backgroundColor: Colors.white,
//           activeColor: Color(0xffFFBD59),
//           items: [
//             TabItem(icon: Icons.home, title: 'Today'),
//             TabItem(icon: Icons.people_alt_sharp, title: 'Community'),
//             TabItem(icon: Icons.add, title: ''),
//             TabItem(icon: Icons.feed, title: 'Feed'),
//             TabItem(icon: Icons.person_2, title: 'Profile'),
//           ],
//         ),