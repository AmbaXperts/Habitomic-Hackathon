import 'package:flutter/material.dart';

class YTextForm extends StatelessWidget {
  final String lableText;
  final TextEditingController controller;
  const YTextForm({
    super.key,
    required this.controller,
    required this.lableText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            lableText,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
