import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/Strorage.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/imagePicker.dart';
import 'package:habitomic_app/features/personalization/controllers/user_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' as foundation;

class PostData extends StatefulWidget {
  const PostData({super.key});

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  Uint8List? file;
  String url = '';

  bool isfinished = true;
  bool isemojishow = false;
  TextEditingController discriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return PopScope(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    height: 600,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 15, left: 20),
                                child: Text(
                                  'Post',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black,
                                    ),
                                    child: Center(
                                      child: Text(
                                        controller.user.value.fullName,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, bottom: 10),
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                        controller.user.value.profilePicture,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              label: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'Write some discription here',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),
                            ),
                            controller: discriptionController,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Stack(
                            children: [
                              file == null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 300,
                                          width: 2,
                                          color: Colors.black45,
                                        ),
                                        Container(
                                          height: 250,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                'https://www.thewall360.com/uploadImages/ExtImages/images1/def-638240706028967470.jpg',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 300,
                                          width: 2,
                                          color: Colors.black45,
                                        ),
                                        Container(
                                          height: 250,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: MemoryImage(file!),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  Uint8List f =
                                      await PickedImage(ImageSource.gallery);

                                  setState(() {
                                    file = f;
                                  });
                                  url = await storageMethods(file!);
                                  print('success');
                                },
                                icon: Icon(Icons.photo_outlined),
                              ),
                              IconButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    isemojishow = !isemojishow;
                                  });
                                  // isemojishow
                                  //     ? showBottomSheet(
                                  //         context: context,
                                  //         builder: (context) {
                                  //           return EmojiPicker(
                                  //             textEditingController:
                                  //                 discriptionController,
                                  //             config: Config(
                                  //               skinToneConfig: SkinToneConfig(
                                  //                 indicatorColor: Colors.blue,
                                  //                 dialogBackgroundColor:
                                  //                     Colors.lightBlue,
                                  //               ),
                                  //               emojiTextStyle:
                                  //                   TextStyle(color: Colors.green),
                                  //               height: 256,
                                  //               checkPlatformCompatibility: true,
                                  //               emojiViewConfig: EmojiViewConfig(
                                  //                 buttonMode: ButtonMode.CUPERTINO,
                                  //                 backgroundColor:
                                  //                     Colors.grey.shade200,
                                  //                 emojiSizeMax: 28 *
                                  //                     (foundation.defaultTargetPlatform ==
                                  //                             TargetPlatform.iOS
                                  //                         ? 1.20
                                  //                         : 1.0),
                                  //               ),
                                  //             ),
                                  //           );
                                  //         },
                                  //       )
                                  //     : Container();
                                },
                                icon: Icon(
                                  Icons.emoji_emotions,
                                ),
                              ),
                              const Icon(
                                Icons.people_alt_outlined,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const SizedBox(
                                height: 50,
                                width: 100,
                                child: DropdownMenu(
                                  label: Text('Community'),
                                  dropdownMenuEntries: [
                                    DropdownMenuEntry(
                                      value: Colors.green,
                                      label: 'hh',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    height: 60,
                    minWidth: 200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Color.fromARGB(255, 111, 86, 175),
                    child: isfinished
                        ? Text(
                            'Post',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 10,
                              color: Colors.green,
                            ),
                          ),
                    onPressed: () async {
                      print(
                          '##########################################################333');
                      print(url);
                      if (url.isNotEmpty) {
                        setState(() {
                          isfinished = false;
                        });
                        String reult =
                            await AuthenticationRepository().UserPosts(
                          FirebaseAuth.instance.currentUser!.uid,
                          controller.user.value.fullName,
                          discriptionController.text,
                          controller.user.value.profilePicture,
                          url,
                          [],
                          [],
                        );
                        setState(() {
                          isfinished = true;
                        });
                        if (reult == 'success') {
                          Get.snackbar(
                            'Posted !',
                            '',
                            margin: EdgeInsets.all(15),
                            duration: Duration(
                              seconds: 2,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            borderRadius: 15,
                            backgroundColor: Colors.greenAccent,
                            snackPosition: SnackPosition.BOTTOM,
                            dismissDirection: DismissDirection.horizontal,
                          );
                        } else {
                          Get.snackbar(
                            ' Error :  Cheak your interet connection',
                            '',
                            margin: EdgeInsets.all(15),
                            duration: Duration(
                              seconds: 2,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            borderRadius: 15,
                            backgroundColor: Color.fromARGB(255, 215, 94, 86),
                            snackPosition: SnackPosition.BOTTOM,
                            dismissDirection: DismissDirection.horizontal,
                          );
                        }
                      } else {
                        Get.snackbar(
                          ' Error : please enter all the fields.',
                          '',
                          margin: EdgeInsets.all(15),
                          duration: Duration(
                            seconds: 2,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          borderRadius: 15,
                          backgroundColor: Color.fromARGB(255, 215, 94, 86),
                          snackPosition: SnackPosition.BOTTOM,
                          dismissDirection: DismissDirection.horizontal,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
