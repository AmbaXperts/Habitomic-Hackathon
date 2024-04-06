import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/common/model/community/community_model.dart';
import 'package:habitomic_app/common/widgets/circular_image/circular_image.dart';
import 'package:habitomic_app/features/personalization/controllers/user_controller.dart';
import 'package:habitomic_app/features/personalization/screens/community/community_card.dart';

class CommunityPage extends StatelessWidget {
  CommunityPage({super.key, required this.community});
  final UserController userController = Get.find();
  final CommunityModel community;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Community Page'), actions: [
          GetBuilder<UserController>(
            builder: (_) {
              final user = userController.user;
              return TCircularImage(
                  image: user.value.profilePicture,
                  fit: BoxFit.cover,
                  isNetworkImage: true);
            },
          ),
        ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              SearchBar(controller: _searchController, hintText: 'Search'),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Your Community'),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: const Text('See All'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: Get.height * 0.3,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('communities')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final List<CommunityModel> communities = snapshot.data!.docs
                        .map((doc) => CommunityModel.fromJson(
                            doc.data() as Map<String, dynamic>))
                        .toList();

                    return ListView.builder(
                      itemCount: communities.length,
                      itemBuilder: (context, index) {
                        final CommunityModel community = communities[index];
                        return CommunityCard(community: community);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Recen Habits'),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: const Text('See All'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(height: Get.width * 0.3,
              child: const Center(
                child:  Text('No Data')
              )),

            ]),
          ),
        ));
  }
}
