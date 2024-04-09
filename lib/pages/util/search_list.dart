// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class SearchList extends StatelessWidget{
final icon;
final String searchName;
final int numberOfSearches;
final color;

  const SearchList(Image image, {
    Key?key,
   required this.icon,
    required this. searchName,
    required this.numberOfSearches,
    required this. color,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
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
                        color:color,
                        child: 
                        Icon(
                          icon,
                        color: Colors.white,)),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                        searchName,
                      style: 
                      TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),),
                      SizedBox(
                        height: 5,
                      ),
                      //subtitile
                      Text(
                        numberOfSearches.toString()+'k followers',
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
            ),
    );
  }
}