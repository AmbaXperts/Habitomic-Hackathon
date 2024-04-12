import 'package:flutter/material.dart';

class smallDots extends StatelessWidget {
  final bool isdone;
  final Color colors;
  const smallDots({
    super.key,
    required this.colors,
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
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: colors,
              borderRadius: BorderRadius.circular(5),
            ),
          );
  }
}
