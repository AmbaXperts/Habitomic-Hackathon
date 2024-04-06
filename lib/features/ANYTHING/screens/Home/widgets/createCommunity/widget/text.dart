import 'package:flutter/material.dart';

class text extends StatelessWidget {
  final String HeadName;
  const text({
    super.key,
    required this.HeadName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          HeadName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Icons.star,
          size: 10,
          color: Colors.red,
        ),
      ],
    );
  }
}
