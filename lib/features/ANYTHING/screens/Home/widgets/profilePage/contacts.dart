import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/createCommunity/widget/textForm.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/profilePage/otherUserProfile.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

TextEditingController searchController = TextEditingController();

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     onPressed: () {},
      //     icon: Icon(
      //       Icons.arrow_back,
      //       size: 30,
      //     ),
      //   ),
      //   title: Center(
      //     child: Text(
      //       'Find your partner',
      //       style: TextStyle(
      //         fontSize: 18,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //   ),
      // ),
      backgroundColor: Colors.grey[200],
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Center(
                            child: Text(
                              'Find your partner',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            'Enter your partner name',
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Recent Searchs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              /////////// this backind is a demo please change it

              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('post')
                    .where('username',
                        isGreaterThanOrEqualTo: searchController.text)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const otherPeopleProfile(
                                  habits: '20',
                                  members: '20',
                                  userPhotoUrl:
                                      'https://www.thewall360.com/uploadImages/ExtImages/images1/def-638240706028967470.jpg',
                                  username: 'yared',
                                  rate: '7',
                                ),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                        'https://www.thewall360.com/uploadImages/ExtImages/images1/def-638240706028967470.jpg',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Yared',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          'Followers',
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
