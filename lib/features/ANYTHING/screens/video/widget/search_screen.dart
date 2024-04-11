import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habitomic_app/common/model/user/user_model.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/profilePage/otherUser.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/profilePage/userProfilePage.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SSearchController searchController = Get.put(SSearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 192, 191, 191),
          title: TextFormField(
            decoration: const InputDecoration(
              filled: false,
              hintText: 'Search',
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onFieldSubmitted: (value) => searchController.searchUser(value),
          ),
        ),
        body: searchController.searchedUsers.isEmpty
            ? const Center(
                child: Text(
                  'Search for users!',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: searchController.searchedUsers.length,
                itemBuilder: (context, index) {
                  UserModel user = searchController.searchedUsers[index];
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OtherUserProfile(uid: user.id),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.profilePicture,
                        ),
                      ),
                      title: Text(
                        user.username,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
