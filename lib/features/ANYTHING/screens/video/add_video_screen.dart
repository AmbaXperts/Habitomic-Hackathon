import 'dart:io';

import 'package:flutter/material.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/conform_video_screen.dart';
import 'package:image_picker/image_picker.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);

    if (video != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ConformVideoScreen(
                videoFile: File(video.path),
                videoPath: video.path,
              )));
    }
  }

  showOptionDialoge(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.gallery, context),
                  child: Row(
                    children: [
                      const Icon(Icons.image),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Text(
                          'Gallary',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.camera, context),
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
            ));
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
                  'Add Video',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ),
    );
  }
}
