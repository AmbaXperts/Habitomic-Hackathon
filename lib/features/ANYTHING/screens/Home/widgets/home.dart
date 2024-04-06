import '/common/widgets/custome_shapes/primery_header_container.dart';
import '/features/ANYTHING/screens/Home/widgets/home_appbar.dart';
import '/utils/constants/sizes.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/home_body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF6F7FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimeryHeaderContainer(
                child: Column(
              children: [THomeAppBar(), THomeBody()],
            )),
          ],
        ),
      ),
    );
  }
}
