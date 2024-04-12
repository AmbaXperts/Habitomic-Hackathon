
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers


import 'package:flutter/material.dart';



import 'package:habitomic_app/pages/util/search_list.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          centerTitle: true,
          title: const Text("Search"),
        ),
backgroundColor: Colors.white,

body:  SafeArea(
  child: Column(children: [
 
  
    //greeting row
    Padding(
       
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            //Search
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                ),
                const SizedBox(height: 8,),
                
              ],
            ),
            //filter
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
            ),
              child: const Icon(
                Icons.filter_alt_sharp,
                size: 35,
                color: Colors.purple,
              ),
            )
          ],),
          SizedBox(
            height: 25,
            ),
          //search bar
          Container(
            
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            
            padding: EdgeInsets.all(12),
            child: const Row(children: [
              
            Icon(
              Icons.search,
              color: Colors.black,
              ),
              SizedBox(
                width: 5,
              ),
              
              Text(
                'Search',
                style: TextStyle(
                  color: Colors.black,
                  
                ),
                ),
                
            ],
            ),
            ),
            SizedBox(
              height: 25,
            ),
            
            

        ],
      ),
    ),

    SizedBox(
      height: 25,
    ),
  
  Expanded(
    child: Container(
      padding: EdgeInsets.all(25),
      
      color: Colors.grey[100],
      child: Center(
        child: Column(children: [
          //recent search heading
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Searches',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),),
              Icon(Icons.more_horiz),
            ],
          ),
          SizedBox(
            height: 20,
          ),

          Expanded(
            child: ListView(
              children: [
                SearchList(
               Image.asset(''),
                  icon:Icons.favorite,
                  searchName: 'A2SV',
                  numberOfSearches: 2,
                  color: Colors.orange,
                ),
                SearchList( 
                   Image.asset(''),
                  icon: Icons.favorite,
                  searchName: 'Ahamenes space Science',
                  numberOfSearches: 12,
                  color: Colors.pink,
               ),
                SearchList( 
                   Image.asset(''),
                  icon: Icons.favorite,
                  searchName: 'Chess Community',
                  numberOfSearches: 16,
                  color: Colors.green,
               ),
              ],
            ),
          ),
          //list view of searches


          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.orange,
                      child: Icon(Icons.favorite,
                      color: Colors.white,)),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('A2Sv',
                    style: 
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),),
                    SizedBox(
                      height: 5,
                    ),
                    //subtitile
                    Text('2k follower',
                    style: 
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 18,
                    ),),
                  ],),
                ],
              ),
              Icon(Icons.more_horiz),
            ],),
          )
        ],
        ),
      ),
    ),
  )
  ],
  ),
),
    );
  }
}