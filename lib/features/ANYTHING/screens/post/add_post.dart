import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitomic_app/features/ANYTHING/screens/post/confirm_post_screen.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key});

  pickImage(ImageSource src, BuildContext context) async {
    final post = await ImagePicker().pickImage(source: src);

    if (post != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ConformPostScreen(
         
          postPath: post.path, 
          postFile:File(post.path),
        ),
      ));
    }
  }

  showOptionDialoge(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () => pickImage(ImageSource.gallery, context),
            child: Row(
              children: [
                const Icon(Icons.image),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Gallery',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => pickImage(ImageSource.camera, context),
            child: Row(
              children: [
                const Icon(Icons.camera_alt),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Camera',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: Row(
              children: [
                const Icon(Icons.cancel),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showOptionDialoge(context),
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue, // replaced by customize button color
            ),
            child: Center(
              child: Text(
                'Add Post',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
