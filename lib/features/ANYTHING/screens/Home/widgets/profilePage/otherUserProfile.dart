// import 'package:flutter/material.dart';
// import 'package:habitomic_app/data/repositories/repositories.authentication/widgets/prof.dart';
// import 'package:intl/intl.dart';

// class otherPeopleProfile extends StatefulWidget {
//   final String username;
//   final String members;
//   final String habits;
//   final String rate;
//   final String userPhotoUrl;
//   const otherPeopleProfile({
//     super.key,
//     required this.habits,
//     required this.members,
//     required this.userPhotoUrl,
//     required this.username,
//     required this.rate,
//   });

//   @override
//   State<otherPeopleProfile> createState() => _otherPeopleProfileState();
// }

// class _otherPeopleProfileState extends State<otherPeopleProfile>
//     with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     TabController tabController = TabController(
//       length: 3,
//       vsync: this,
//     );
//     return DefaultTabController(
//       length: 3,
//       initialIndex: 0,
//       child: Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(
//               Icons.arrow_back,
//               size: 30,
//             ),
//           ),
//         ),
//         body: SafeArea(
//           child: NestedScrollView(
//             headerSliverBuilder: (context, innerBoxIsScrolled) {
//               return [
//                 SliverAppBar(
//                   pinned: true,
//                   floating: true,
//                   automaticallyImplyLeading: false,
//                   expandedHeight: 450,
//                   flexibleSpace: ListView(
//                     children: [
//                       Column(
//                         children: [
//                           ProfileUtil(
//                             username: '@yared',
//                             fullname: 'yared dereje',
//                             date: DateFormat.yMMM(),
//                             isuserprofile: false,
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   bottom: TabBar(
//                     controller: tabController,
//                     onTap: (value) {},
//                     unselectedLabelColor: Colors.grey[400],
//                     tabAlignment: TabAlignment.center,
//                     isScrollable: true,
//                     tabs: [
//                       Tab(
//                         child: Container(
//                           height: 50,
//                           width: 120,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.greenAccent),
//                             borderRadius: BorderRadius.circular(15),
//                             color: const Color.fromRGBO(238, 238, 238, 1),
//                           ),
//                           child: Center(
//                             child: Text(
//                               'Posts',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Tab(
//                         child: Container(
//                           height: 50,
//                           width: 120,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.greenAccent),
//                             borderRadius: BorderRadius.circular(15),
//                             color: const Color.fromRGBO(238, 238, 238, 1),
//                           ),
//                           child: Center(
//                             child: Text(
//                               'Habits',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Tab(
//                         child: Container(
//                           height: 50,
//                           width: 150,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.greenAccent),
//                             borderRadius: BorderRadius.circular(15),
//                             color: const Color.fromRGBO(238, 238, 238, 1),
//                           ),
//                           child: Center(
//                             child: Text(
//                               'Communities',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ];
//             },
//             body: TabBarView(
//               controller: tabController,
//               children: [
//                 Container(
//                   color: Colors.green,
//                 ),
//                 Container(
//                   color: Colors.yellow,
//                 ),
//                 Container(
//                   color: Colors.red,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
