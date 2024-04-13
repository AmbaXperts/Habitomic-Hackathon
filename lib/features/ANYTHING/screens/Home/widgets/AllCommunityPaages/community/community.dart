import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/joinCommunity.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/AllCommunityPaages/community/createComm.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/profilePage/contacts.dart';
class CommunitySeo extends StatefulWidget {
  const CommunitySeo({Key? key}) : super(key: key);

  @override
  State<CommunitySeo> createState() => _CommunitySeoState();
}

class _CommunitySeoState extends State<CommunitySeo> {
  late String searchterm;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchterm = "";
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;

    return Scaffold(
      backgroundColor: brightness == Brightness.light ? Colors.grey[200] : Colors.grey[800],
      body: ListView(
        children: [
          Column(
            children: [
             Container(
  height: 200,
  decoration: BoxDecoration(
    color: brightness == Brightness.light ? Colors.white : const Color.fromARGB(255, 92, 91, 91),
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(15),
    child: Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                color: brightness == Brightness.light ? Colors.black : Colors.white,
              ),
            ),
             Text(
              'Community search',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: brightness == Brightness.light ? Colors.black : Colors.white,
              ),
            ),
            const SizedBox(
              width: 20,
              height: 20,
            )
          ],
        ),
        const SizedBox(height: 30),
        TextFormField(
          controller: searchController,
          onChanged: (value) {
            setState(() {
              searchterm = value;
            });
          },
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            label: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Search'),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            fillColor: brightness == Brightness.light ? Colors.white : Colors.grey[600],
            filled: true,
          ),
        ),
      ],
    ),
  ),
),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Community',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Ycommunity')
                    .where("commName", isGreaterThanOrEqualTo: searchterm)
                    .where('commName', isLessThan: searchterm + 'z')
                    .orderBy("commName")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData) {
                    return const Text(
                      'You have no communities yet. Join the community on the profile page.',
                    );
                  }
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Ycommunity')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (!snapshot.hasData) {
                        return const Text(
                          'You have no communities yet. Join the community on the profile page.',
                        );
                      }
                      var doco = snapshot.data!.docs;

                      return SizedBox(
                        height: 270,
                        child: ListView.builder(
                          itemCount: doco.length,
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
                                              doco[index]['commPictrue'],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '  ${doco[index]['commName']}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            '  ${doco[index]['commMembers'].length} followers',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      print(
                                        doco[index]['commMembers'],
                                      );
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => joinCommunity(
                                            like: doco[index]['commLikes'],
                                            uuid: doco[index]['Uuid'],
                                            comBio: doco[index]['commBio'],
                                            comHabits: doco[index]['commHabits'],
                                            comMembers: doco[index]['commMembers'],
                                            comPicture: doco[index]['commPictrue'],
                                            comname: doco[index]['commName'],
                                            rating: doco[index]['commRating'],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                      size: 30,
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
              const SizedBox(height: 15),
            ],
          ),
        ],
      ),
    );
  }
}
