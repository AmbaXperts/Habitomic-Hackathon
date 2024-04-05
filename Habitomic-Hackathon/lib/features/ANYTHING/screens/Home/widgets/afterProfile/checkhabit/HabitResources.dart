import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get_connect/http/src/_http/_io/_file_decoder_io.dart';

class Resources extends StatefulWidget {
  const Resources({super.key});

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'videos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 25,
                      left: 15,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvZIhlyCIfIfvSXWqjpsl9nOClO7bNLmJNjD4lIRsLxkOciRGYyx_vJxTgpMUFOtmx7yw&usqp=CAU',
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              right: 40,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.play_circle_outlined,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Quee Trap',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.timer_sharp),
                            Text(
                              ' 5 min',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Books',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                height: 150,
                width: 450,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    materialbutton(
                      icons: Icons.local_library_outlined,
                      name: 'PDF',
                    ),
                    materialbutton(
                      icons: Icons.language_outlined,
                      name: 'Online',
                    ),
                    materialbutton(
                      icons: Icons.audiotrack_outlined,
                      name: 'Audio',
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class materialbutton extends StatelessWidget {
  final IconData icons;
  final String name;
  const materialbutton({
    super.key,
    required this.icons,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: MaterialButton(
        color: Colors.purple,
        height: 70,
        minWidth: 70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onPressed: () {},
        child: Column(
          children: [
            Icon(
              icons,
              size: 40,
              color: Colors.white,
            ),
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
