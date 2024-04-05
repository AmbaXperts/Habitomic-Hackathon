import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileUtil extends StatefulWidget {
  final String username;
  final String fullname;
  final DateFormat date;
  final bool isuserprofile;
  const ProfileUtil({
    super.key,
    required this.username,
    required this.fullname,
    required this.date,
    required this.isuserprofile,
  });

  @override
  State<ProfileUtil> createState() => _ProfileUtilState();
}

TextEditingController BioController = TextEditingController();

class _ProfileUtilState extends State<ProfileUtil> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      height: 380,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://www.thewall360.com/uploadImages/ExtImages/images1/def-638240706028967470.jpg',
                      ),
                      radius: 40,
                    ),
                    Positioned(
                      bottom: -2,
                      right: 0,
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: ClipOval(
                          clipBehavior: Clip.antiAlias,
                          child: Material(
                            color: Color.fromARGB(255, 163, 94, 176),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                color: Colors.white,
                                Icons.edit,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.fullname}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.username}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[500],
                        ),
                      ),
                      Row(
                        children: [
                          widget.isuserprofile
                              ? Icon(
                                  Icons.av_timer_rounded,
                                )
                              : Container(),
                          widget.isuserprofile
                              ? Text(
                                  'Member since ${widget.date.format(DateTime.now())}',
                                )
                              : MaterialButton(
                                  height: 60,
                                  minWidth: 150,
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'Follow',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Bio',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BioDiscription(),
                  ),
                );
              },
              child: BioController.text == ""
                  ? Text(
                      'write some discription',
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    )
                  : Text(
                      BioController.text,
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                rowcolumn('Community', '2'),
                rowcolumn('Habits', '3'),
                rowcolumn('Rating', '5'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row rowcolumn(String title, String howMuch) {
    return Row(
      children: [
        Column(
          children: [
            Icon(
              Icons.people_alt_outlined,
              size: 40,
            ),
            Text(
              title,
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            Text(howMuch),
          ],
        ),
      ],
    );
  }

  Widget BioDiscription() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.check,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: BioController,
                decoration: InputDecoration(
                  label: Text('Bio'),
                ),
                onChanged: (value) => setState(() {}),
              ),
              Text(
                'write some discription about your self',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
