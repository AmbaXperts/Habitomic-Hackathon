import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/controller/upload_video_controller.dart';
import 'package:habitomic_app/features/ANYTHING/screens/video/widget/inpu_field.dart';
import 'package:video_player/video_player.dart';
import 'dart:io' if (dart.library.io) 'dart:ui' as ui;

class ConformVideoScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const ConformVideoScreen({
    Key? key,
    required this.videoFile,
    required this.videoPath,
  }) : super(key: key);

  @override
  State<ConformVideoScreen> createState() => _ConformVideoScreenState();
}

class _ConformVideoScreenState extends State<ConformVideoScreen> {
  late VideoPlayerController controller;
  TextEditingController _songController = TextEditingController();
  TextEditingController _captionController = TextEditingController();
  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(widget.videoFile);
    controller.initialize().then((_) {
      if (mounted) {
        setState(() {}); // Update the state once the video is initialized
      }
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
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
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
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
                      controller: _songController,
                      icon: Icons.music_note,
                      labelText: 'Song Name',
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
                    onPressed: () => uploadVideoController.uploadVideo(
                      _songController.text,
                      _captionController.text,
                      widget.videoPath,
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
