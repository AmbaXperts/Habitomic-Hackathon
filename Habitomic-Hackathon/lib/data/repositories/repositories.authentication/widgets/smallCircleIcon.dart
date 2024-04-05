import 'package:flutter/material.dart';

class smallCircleIcon extends StatefulWidget {
  final Icon icons;
  final Color backgroundColor;
  final VoidCallback? onpressed;
  const smallCircleIcon({
    super.key,
    required this.onpressed,
    required this.icons,
    required this.backgroundColor,
  });

  @override
  State<smallCircleIcon> createState() => _smallCircleIconState();
}

class _smallCircleIconState extends State<smallCircleIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onpressed,
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: widget.icons,
        ),
      ),
    );
  }
}
