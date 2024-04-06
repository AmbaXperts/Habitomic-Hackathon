import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/createCommunity/widget/text.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/createCommunity/widget/textForm.dart';

class CreateCommunity extends StatefulWidget {
  const CreateCommunity({super.key});

  @override
  State<CreateCommunity> createState() => _CreateCommunityState();
}

class _CreateCommunityState extends State<CreateCommunity> {
  TextEditingController commName = TextEditingController();
  TextEditingController commHabits = TextEditingController();
  TextEditingController commBio = TextEditingController();

  int n = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.clear_outlined,
            size: 30,
          ),
        ),
        title: const Center(
          child: Text('Create A Community '),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const text(
                  HeadName: 'Community Name',
                ),
                const SizedBox(
                  height: 15,
                ),
                YTextForm(
                  controller: commName,
                  lableText: 'Type Your Community Name',
                ),
                const SizedBox(
                  height: 15,
                ),
                const text(
                  HeadName: 'Community Picture',
                ),
                const SizedBox(
                  height: 15,
                ),
                Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://www.google.com/imgres?q=default%20image&imgurl=https%3A%2F%2Fwww.thewall360.com%2FuploadImages%2FExtImages%2Fimages1%2Fdef-638240706028967470.jpg&imgrefurl=https%3A%2F%2Fwww.thewall360.com%2Ffeatures%2F303%2Fdefault-picture&docid=Sgknr3Enmn2H_M&tbnid=8piXv0hEQwpvaM&vet=12ahUKEwjy7_SL_auFAxV4FlkFHZzSB0oQM3oECD4QAA..i&w=560&h=373&hcb=2&ved=2ahUKEwjy7_SL_auFAxV4FlkFHZzSB0oQM3oECD4QAA',
                          ),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.upload_sharp,
                          size: 40,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const text(
                  HeadName: 'Create Habits',
                ),
                const SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.blueAccent,
                  height: 50,
                  minWidth: 100,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Dialog(
                              child: ListView.builder(
                                itemCount: n,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      const text(
                                        HeadName: 'Give 3  Key Habit',
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      text(HeadName: 'Week ${index + 1}'),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      YTextForm(
                                        controller: commHabits,
                                        lableText: ' Write Habit 1',
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      YTextForm(
                                        controller: commHabits,
                                        lableText: ' Write Habit 2',
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      YTextForm(
                                        controller: commHabits,
                                        lableText: ' Write Habit 3',
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            height: 40,
                                            minWidth: 40,
                                            color: Colors.blueAccent,
                                            onPressed: () {
                                              setState(() {
                                                n++;
                                              });
                                              print(
                                                  '######################33${n}');
                                            },
                                            child:
                                                Text('Add Weak ${index + 2}'),
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Create Habits',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                text(
                  HeadName: 'Community Bio',
                ),
                const SizedBox(
                  height: 15,
                ),
                YTextForm(
                  controller: commBio,
                  lableText: 'Write Something About Your Community',
                ),
                const SizedBox(
                  height: 15,
                ),
                text(
                  HeadName: 'Community Resource',
                ),
                const SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  color: Colors.blueAccent,
                  height: 40,
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Dialog(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: n,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            const text(
                                              HeadName: 'Video',
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            YTextForm(
                                              controller: commHabits,
                                              lableText:
                                                  'Write the Name of video',
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            YTextForm(
                                              controller: commHabits,
                                              lableText: ' Write the link ',
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: const DecorationImage(
                                                  image: NetworkImage(
                                                    'https://www.google.com/imgres?q=default%20image&imgurl=https%3A%2F%2Fwww.thewall360.com%2FuploadImages%2FExtImages%2Fimages1%2Fdef-638240706028967470.jpg&imgrefurl=https%3A%2F%2Fwww.thewall360.com%2Ffeatures%2F303%2Fdefault-picture&docid=Sgknr3Enmn2H_M&tbnid=8piXv0hEQwpvaM&vet=12ahUKEwjy7_SL_auFAxV4FlkFHZzSB0oQM3oECD4QAA..i&w=560&h=373&hcb=2&ved=2ahUKEwjy7_SL_auFAxV4FlkFHZzSB0oQM3oECD4QAA',
                                                  ),
                                                ),
                                              ),
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.upload_sharp,
                                                  size: 40,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  height: 40,
                                                  minWidth: 40,
                                                  color: Colors.blueAccent,
                                                  onPressed: () {
                                                    setState(() {
                                                      n++;
                                                    });
                                                    print(
                                                        '######################33${n}');
                                                  },
                                                  child: Text(
                                                      'Add more link ${index + 2}'),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  text(
                                    HeadName: 'Books',
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'PDF',
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    height: 40,
                                    minWidth: 40,
                                    color: Colors.blueAccent,
                                    onPressed: () {},
                                    child: Text('Attach file'),
                                  ),
                                  text(
                                    HeadName: 'Audio',
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    height: 40,
                                    minWidth: 40,
                                    color: Colors.blueAccent,
                                    onPressed: () {},
                                    child: Text('Attach audio'),
                                  ),
                                  SizedBox(
                                    height: 150,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    'Give Resource',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
