import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/afterProfile/joinCommunity.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/AllCommunityPaages/community/createComm.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/profilePage/contacts.dart';

class commSearch extends StatefulWidget {
  const commSearch({super.key});

  @override
  State<commSearch> createState() => _commSearchState();
}

class _commSearchState extends State<commSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView(
        children: [
          Column(
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Community',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MaterialButton(
                            height: 60,
                            minWidth: 100,
                            color: Color.fromARGB(255, 111, 161, 246),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CreateCommunity(),
                              ));
                            },
                            child: Text(
                              'Create community',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          label: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Search'),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
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
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Your Community',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'All',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
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
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                'https://www.thewall360.com/uploadImages/ExtImages/images1/def-638240706028967470.jpg',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'A2SV Community',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '2k Followers',
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => joinCommunity(
                                comBio: 'this is some discription',
                                comHabits: '45',
                                comMembers: '56',
                                comPicture:
                                    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.flashintel.ai%2Fcompanies%2FA2SV-%257C-Africa-to-Silicon-Valley-275924e9edcffcd03c442d0f14eb46c0%2F&psig=AOvVaw2ogV9kvmqK0LNyNUjagHRb&ust=1712560408742000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCKCy5erGr4UDFQAAAAAdAAAAABAE',
                                comname: 'A2SV',
                                rating: '7'),
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
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Habits',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'All',
                        style: TextStyle(
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
                                image: DecorationImage(
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
                        SizedBox(
                          width: 15,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'A2SV Community',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '2k Followers',
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward,
                        size: 30,
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
