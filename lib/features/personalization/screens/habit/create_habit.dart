import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/common/widgets/Textfield/text_field.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({super.key});

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  int selectedIndex = -1;
  TextEditingController habitTitleController = TextEditingController();
  TextEditingController habitDetailController = TextEditingController();

  List<Button> timeZone = [
    Button(title: 'Morning'),
    Button(title: 'Afternoon'),
    Button(title: 'Evening'),
    Button(title: 'Night'),
    Button(title: 'Anytime'),
    Button(title: 'Add More'),
    Button(title: 'Morning'),
  ];

  @override
  void dispose() {
    super.dispose();
    habitTitleController.dispose();
    habitDetailController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text('Create New Habit'),
            const SizedBox(
              height: 10,
            ),
            StyledTextFormField(
                labelText: 'Habit Title', controller: habitTitleController),
            const SizedBox(
              height: 10,
            ),
            StyledTextFormField(
                labelText: 'Habit Detail', controller: habitDetailController),
            const SizedBox(
              height: 10,
            ),
            const Text('Choose time in a Day'),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                timeZone.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      timeZone[index].isTapped = true;
                    });
                  },
                  child: timeZone[index],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: (){}, child: const Center(
              child: Text('Add to my Plan'),
            ))
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  Button({super.key, required this.title});
  final String title;
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width * 0.3,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: isTapped ? Colors.white : Colors.amber),
      child: Center(
        child: Text(
          title,
        ),
      ),
    );
  }
}
