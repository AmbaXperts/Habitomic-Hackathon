import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class THomeBody extends StatelessWidget {
  const THomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    final bool isDark = brightnessValue == Brightness.dark;

    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(17),
      height: size.height * 0.47,
      width: size.width,
      color: isDark ? Colors.grey[900] : Color(0xffF6F7FB),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              "assets/animations/4.json",
              width: 250,
              height: 250,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Start Exploring',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ]),
    );
  }
}
