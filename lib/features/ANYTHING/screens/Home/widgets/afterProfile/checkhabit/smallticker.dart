import 'package:flutter/material.dart';

class smallDots extends StatelessWidget {
  final bool isdone;
  const smallDots({
    super.key,
    required this.isdone,
  });

  @override
  Widget build(BuildContext context) {
    return isdone
        ? Icon(
            Icons.done,
            color: Colors.white,
          )
        : Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          );
  }
}
