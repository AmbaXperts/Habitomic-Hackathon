import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/AllCommunityPaages/community/community.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/joinCommunity.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/AllCommunityPaages/community/createComm.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/profilePage/contacts.dart';
import 'package:habitomic_app/utils/constants/text_strings.dart';
import '/utils/helpers/helper_function.dart';

class commSearch extends StatefulWidget {
  const commSearch({super.key});

  @override
  State<commSearch> createState() => _commSearchState();
}

class _commSearchState extends State<commSearch> {
  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    final bool isDark = brightnessValue == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[200],
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: 110,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Community',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          MaterialButton(
                            height: 60,
                            minWidth: 100,
                            color: const Color.fromARGB(255, 111, 161, 246),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CreateCommunity(),
                              ));
                            },
                            child: const Text(
                              'Create community',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CommunitySeo(),
                            )),
                            child: Icon(
                              Icons.search,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Your Community',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child:  Text(
                        'All',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Ycommunity').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData) {
                    return Text(
                      'you have no communitys yet . Join the community on profile page .',
                      style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    );
                  }
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Ycommunity').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (!snapshot.hasData) {
                        return Text(
                          'you have no communitys yet . Join the community on profile page .',
                          style: TextStyle(color: isDark ? Colors.white : Colors.black),
                        );
                      }
                      var doco = snapshot.data!.docs;
                      var newdoc = [];
                      for (int i = 0; i < doco.length; i++) {
                        var kelp = doco[i]["commMembers"];
                        if (kelp.any((element) => element['userId'] == FirebaseAuth.instance.currentUser!.uid)) {
                          newdoc.add(doco[i]);
                        }
                      }
                      return SizedBox(
                        height: 270,
                        child: ListView.builder(
                          itemCount: newdoc.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                              newdoc[index]['commPictrue'],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '  ${newdoc[index]['commName']}',
                                            style: TextStyle(
                                              color: isDark ? Colors.white : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            '  ${newdoc[index]['commMembers'].length} followers',
                                            style: TextStyle(
                                              color: isDark ? Colors.white : Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      print(newdoc[index]['commMembers']);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => joinCommunity(
                                            like: newdoc[index]['commLikes'],
                                            uuid: newdoc[index]['Uuid'],
                                            comBio: newdoc[index]['commBio'],
                                            comHabits: newdoc[index]['commHabits'],
                                            comMembers: newdoc[index]['commMembers'],
                                            comPicture: newdoc[index]['commPictrue'],
                                            comname: newdoc[index]['commName'],
                                            rating: newdoc[index]['commRating'],
                                          ),
                                        ),
                                      );
                                    },
                                    icon:  Icon(
                                      Icons.arrow_forward,
                                      size: 30,
                                      color: isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Recent Habits',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child:  Text(
                        'All',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    'https://www.thewall360.com/uploadImages/ExtImages/images1/def-638240706028967470.jpg',
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              right: -3,
                              bottom: -3,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundImage: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuKMehy8HD_FTHTVUfOxf4IXYRo0ZcdHL7Y0TGPVuzRA&s',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'A2SV Community',
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '2k Followers',
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon:  Icon(
                        Icons.arrow_forward,
                        size: 30,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
