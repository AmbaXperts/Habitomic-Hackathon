import 'package:flutter/material.dart';
import 'package:habitomic_app/common/model/community/community_model.dart';

class CommunityCard extends StatelessWidget {
  final CommunityModel community;

  const CommunityCard({super.key, required this.community});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(community.imgUrl ?? ''),
        ),
        title: Text(community.communityName ?? ''),
        subtitle: Text('${community.followers!.length} Followers'),
        onTap: () {
          // Navigate to community details page or perform any action
        },
      ),
    );
  }
}