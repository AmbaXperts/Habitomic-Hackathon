import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:habitomic_app/features/ANYTHING/screens/post/controller/upload_post_controller.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/widget/inpu_field.dart'; // Adjust import path if necessary

class ConformPostScreen extends StatefulWidget {
  final File postFile;
  final String postPath;

  const ConformPostScreen({
    Key? key,
    required this.postFile,
    required this.postPath, 
  }) : super(key: key);

  @override
  State<ConformPostScreen> createState() => _ConformImageScreenState();
}

class _ConformImageScreenState extends State<ConformPostScreen> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _captionController = TextEditingController(); // Corrected variable name
  UploadPostController uploadImageController = Get.put(UploadPostController());

  @override
  void dispose() {
    _descriptionController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Image.file(widget.postFile),

            ),
            const SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: _descriptionController,
                      icon: Icons.description,
                      labelText: 'Description',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: _captionController,
                      icon: Icons.closed_caption,
                      labelText: 'Caption',
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => uploadImageController.uploadImage(
                      _descriptionController.text,
                      _captionController.text,
                      widget.postPath,
                    ),
                    child: const Text(
                      "Share",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
