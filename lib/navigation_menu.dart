import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/AllCommunityPaages/community/createComm.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/AllCommunityPaages/community/communitySearch.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/feedScreenui/feedScreen.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/postPage/postscreen.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/profilePage/userProfilePage.dart';

import '/features/ANYTHING/screens/Home/widgets/home.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final pages = [
    const HomeScreen(),
    const commSearch(),
    const PostData(),
    const Feed(),
    const userProfileScreen(),
  ];
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: ConvexAppBar(
        height: 80,
        elevation: 0,
        initialActiveIndex: 0,
        style: TabStyle.fixedCircle,
        color: Colors.grey,
        backgroundColor: Colors.white,
        activeColor: Color(0xffFFBD59),
        items: [
          TabItem(icon: Icons.home, title: 'Today'),
          TabItem(icon: Icons.people_alt_sharp, title: 'Lobby'),
          TabItem(icon: Icons.add, title: ''),
          TabItem(icon: Icons.feed, title: 'Feed'),
          TabItem(icon: Icons.person_2, title: 'Profile'),
        ],
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
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