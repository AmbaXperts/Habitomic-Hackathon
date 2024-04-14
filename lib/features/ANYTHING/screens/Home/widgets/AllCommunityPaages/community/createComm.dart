import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/Strorage.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/YallAuth.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/authentication_repository.dart';
import 'package:habitomic_app/data/repositories/repositories.authentication/imagePicker.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/AllCommunityPaages/creator.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/AllCommunityPaages/widget/text.dart';
import 'package:habitomic_app/features/ANYTHING/screens/Home/widgets/AllCommunityPaages/widget/textForm.dart';
import 'package:habitomic_app/utils/popups/loaders.dart';
import 'package:habitomic_app/utils/snackBar/snackbar.dart';
import 'package:image_picker/image_picker.dart';

class CreateCommunity extends StatefulWidget {
  const CreateCommunity({super.key});

  @override
  State<CreateCommunity> createState() => _CreateCommunityState();
}

class _CreateCommunityState extends State<CreateCommunity> {
  List habito = [];

  TextEditingController commName = TextEditingController();
  TextEditingController commBio = TextEditingController();
  TextEditingController commHabits1 = TextEditingController();
  TextEditingController commHabits2 = TextEditingController();
  TextEditingController commHabits3 = TextEditingController();
  TextEditingController commHabits4 = TextEditingController();
  TextEditingController commHabits5 = TextEditingController();
  TextEditingController commHabits6 = TextEditingController();
  TextEditingController commHabits7 = TextEditingController();
  TextEditingController commHabits8 = TextEditingController();
  TextEditingController commHabits9 = TextEditingController();
  TextEditingController commHabits10 = TextEditingController();
  TextEditingController commHabits11 = TextEditingController();
  TextEditingController commHabits12 = TextEditingController();
  TextEditingController commVedioName1 = TextEditingController();
  TextEditingController commVedioLink1 = TextEditingController();
  TextEditingController commVedioName2 = TextEditingController();
  TextEditingController commVedioLink2 = TextEditingController();
  TextEditingController commVedioName3 = TextEditingController();
  TextEditingController commVedioLink3 = TextEditingController();
  TextEditingController commVedioName4 = TextEditingController();
  TextEditingController commVedioLink4 = TextEditingController();

  // int change = 0;
  bool isfinish = true;
  String? vedioImage1;
  String? vedioImage2;
  String? vedioImage3;
  String? vedioImage4;

  String? photolink;
  String? commPdf;
  String? commAudio;
  Uint8List? image;

  PlatformFile? pickedFile;
  PlatformFile? pickaudio;

  @override
  Widget build(BuildContext context) {
    List vedioImage = [
      vedioImage1,
      vedioImage2,
      vedioImage3,
      vedioImage4,
    ];
    List<TextEditingController> createHabController = [
      commHabits1,
      commHabits2,
      commHabits3,
      commHabits4,
      commHabits5,
      commHabits6,
      commHabits7,
      commHabits8,
      commHabits9,
      commHabits10,
      commHabits11,
      commHabits12,
    ];

    List vediocontroller = [
      [commVedioName1, commVedioLink1, vedioImage1],
      [commVedioName2, commVedioLink2, vedioImage2],
      [commVedioName3, commVedioLink3, vedioImage3],
      [commVedioName4, commVedioLink4, vedioImage4],
    ];

    void posted() async {
      if (commBio.text.isNotEmpty &&
          commName.text.isNotEmpty &&
          createHabController[0].text.isNotEmpty &&
          image != null &&
          vediocontroller[0][0].text.isNotEmpty &&
          vediocontroller[0][1].text.isNotEmpty &&
          vediocontroller[0][2] != null) {
        String result = await authMethod().addProduct(
            habits: createHabController,
            commBio: commBio.text,
            commImg: image!,
            commTitle: commName.text,
            videos: vediocontroller);

        if (result == 'success') {
          Loader.successSnackBar(
              title: "Community Creation", message: 'Successfully added');
        } else {
          Loader.customToast(
            message: result,
          );
        }
      } else {
        Loader.errorSnackBar(
          title: "Error",
          message: 'Please fill in all the required fields',
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.clear_outlined,
            size: 30,
          ),
        ),
        title: const Center(
          child: Text('Create A Community '),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const text(
                  HeadName: 'Community Name',
                ),
                const SizedBox(
                  height: 15,
                ),
                YTextForm(
                  controller: commName,
                  lableText: 'Type Your Community Name',
                ),
                const SizedBox(
                  height: 15,
                ),
                const text(
                  HeadName: 'Community Picture',
                ),
                const SizedBox(
                  height: 15,
                ),
                Stack(
                  children: [
                    image == null
                        ? Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(15),
                              image: const DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  'https://www.thewall360.com/uploadImages/ExtImages/images1/def-638240706028967470.jpg',
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: MemoryImage(image!),
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          Uint8List f = await PickedImage(
                            ImageSource.gallery,
                          );
                          setState(
                            () {
                              image = f;
                            },
                          );
                          var kelp = await storageMethods(image!);
                          setState(
                            () {
                              photolink = kelp;
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.upload_sharp,
                          size: 40,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const text(
                      HeadName: 'Create Habits',
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.blueAccent,
                      height: 40,
                      minWidth: 30,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                top: 10,
                                right: 10,
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  text(HeadName: 'New Habit'),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  YTextForm(
                                    controller: createHabController[0],
                                    lableText: ' Write Habit 1',
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        height: 50,
                                        minWidth: 50,
                                        color: Colors.blueAccent,
                                        onPressed: () {
                                          if (createHabController[0].text ==
                                              "") {
                                            Loader.errorSnackBar(
                                                title:
                                                    "Add the necessary fields with datas");
                                          } else {
                                            setState(
                                              () {
                                                habito.add(
                                                    createHabController[0]
                                                        .text
                                                        .trim());
                                                print(habito);
                                              },
                                            );
                                            createHabController[0].text = "";
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: const Text(
                                          ' Finish',
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ));
                          },
                        );
                      },
                      child: const Icon(Icons.add),
                    )
                  ],
                ),
                Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(41, 110, 110, 110),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListView.builder(
                      itemCount: habito.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: 500,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 300,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green[300],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(habito[index])
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      habito.removeAt(index);
                                    });
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                const text(
                  HeadName: 'Community Bio',
                ),
                const SizedBox(
                  height: 15,
                ),
                YTextForm(
                  controller: commBio,
                  lableText: 'Write Something About Your Community',
                ),
                const SizedBox(
                  height: 15,
                ),
                // const text(
                //   HeadName: 'Community Resource',
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // MaterialButton(
                //   color: Colors.blueAccent,
                //   height: 60,
                //   minWidth: 100,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   onPressed: () {
                //     showDialog(
                //       context: context,
                //       builder: (context) {
                //         return StatefulBuilder(
                //           builder: (context, setState) {
                //             return Dialog(
                //               child: Column(
                //                 children: [
                //                   Expanded(
                //                     child: ListView.builder(
                //                       itemCount: 4,
                //                       itemBuilder: (context, index) {
                //                         return Padding(
                //                           padding: const EdgeInsets.only(
                //                             left: 10,
                //                             top: 10,
                //                             right: 10,
                //                           ),
                //                           child: Column(
                //                             children: [
                //                               const text(
                //                                 HeadName: 'Video',
                //                               ),
                //                               const SizedBox(
                //                                 height: 15,
                //                               ),
                //                               YTextForm(
                //                                 controller:
                //                                     vediocontroller[index][0],
                //                                 lableText:
                //                                     'Write the Name of video',
                //                               ),
                //                               const SizedBox(
                //                                 height: 15,
                //                               ),
                //                               YTextForm(
                //                                 controller: index == 0
                //                                     ? vediocontroller[index + 1]
                //                                     : index == 1
                //                                         ? vediocontroller[
                //                                             index + 2]
                //                                         : index == 2
                //                                             ? vediocontroller[
                //                                                 index + 3]
                //                                             : index == 3
                //                                                 ? vediocontroller[
                //                                                     index + 4]
                //                                                 : ShowSnacks,
                //                                 lableText: ' Write the link ',
                //                               ),
                //                               const SizedBox(
                //                                 height: 15,
                //                               ),
                //                               Stack(
                //                                 children: [
                //                                   vedioImage[index] == null
                //                                       ? Container(
                //                                           height: 100,
                //                                           width: 100,
                //                                           decoration:
                //                                               BoxDecoration(
                //                                             border: Border.all(
                //                                                 color: Colors
                //                                                     .blue),
                //                                             borderRadius:
                //                                                 BorderRadius
                //                                                     .circular(
                //                                                         15),
                //                                             image:
                //                                                 const DecorationImage(
                //                                               fit: BoxFit.fill,
                //                                               image:
                //                                                   NetworkImage(
                //                                                 'https://www.thewall360.com/uploadImages/ExtImages/images1/def-638240706028967470.jpg',
                //                                               ),
                //                                             ),
                //                                           ),
                //                                         )
                //                                       : Container(
                //                                           height: 100,
                //                                           width: 100,
                //                                           decoration:
                //                                               BoxDecoration(
                //                                             borderRadius:
                //                                                 BorderRadius
                //                                                     .circular(
                //                                                         15),
                //                                             image:
                //                                                 DecorationImage(
                //                                               fit: BoxFit.fill,
                //                                               image:
                //                                                   NetworkImage(
                //                                                 vedioImage[
                //                                                     index],
                //                                               ),
                //                                             ),
                //                                           ),
                //                                         ),
                //                                   Padding(
                //                                     padding:
                //                                         const EdgeInsets.only(
                //                                       top: 20,
                //                                       left: 20,
                //                                     ),
                //                                     child: IconButton(
                //                                       onPressed: () async {
                //                                         Uint8List f =
                //                                             await PickedImage(
                //                                           ImageSource.gallery,
                //                                         );
                //                                         setState(
                //                                           () async {
                //                                             String a =
                //                                                 await storageMethods(
                //                                                     f);
                //                                             vedioImage[index] =
                //                                                 a;
                //                                           },
                //                                         );
                //                                       },
                //                                       icon: const Icon(
                //                                         Icons.upload_sharp,
                //                                         size: 40,
                //                                         color: Colors.blue,
                //                                       ),
                //                                     ),
                //                                   ),
                //                                 ],
                //                               ),
                //                               const SizedBox(
                //                                 height: 15,
                //                               ),
                //                               index == 3
                //                                   ? Row(
                //                                       mainAxisAlignment:
                //                                           MainAxisAlignment
                //                                               .center,
                //                                       children: [
                //                                         MaterialButton(
                //                                           shape:
                //                                               RoundedRectangleBorder(
                //                                             borderRadius:
                //                                                 BorderRadius
                //                                                     .circular(
                //                                                         15),
                //                                           ),
                //                                           height: 40,
                //                                           minWidth: 40,
                //                                           color:
                //                                               Colors.blueAccent,
                //                                           onPressed: () {
                //                                             Navigator.of(
                //                                                     context)
                //                                                 .pop();
                //                                           },
                //                                           child: const Text(
                //                                             ' Finish',
                //                                           ),
                //                                         ),
                //                                       ],
                //                                     )
                //                                   : Container(),
                //                             ],
                //                           ),
                //                         );
                //                       },
                //                     ),
                //                   ),
                //                   const Padding(
                //                     padding: EdgeInsets.only(
                //                       left: 10,
                //                     ),
                //                     child: text(
                //                       HeadName: 'Books',
                //                     ),
                //                   ),
                //                   const SizedBox(
                //                     height: 15,
                //                   ),
                //                   const Text(
                //                     'PDF',
                //                   ),
                //                   MaterialButton(
                //                     shape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(15),
                //                     ),
                //                     height: 60,
                //                     minWidth: 40,
                //                     color: Colors.blueAccent,
                //                     onPressed: () async {
                //                       final result =
                //                           await FilePicker.platform.pickFiles();
                //                       if (result != null) {
                //                         setState(
                //                           () {
                //                             pickedFile = result.files.first;
                //                           },
                //                         );

                //                         //the file url

                //                         final str =
                //                             await pickingFile(pickedFile!);
                //                         setState(
                //                           () {
                //                             commPdf = str;
                //                           },
                //                         );
                //                       }
                //                     },
                //                     child: const Text('Attach file'),
                //                   ),
                //                   const Padding(
                //                     padding: EdgeInsets.only(
                //                       left: 10,
                //                     ),
                //                     child: text(
                //                       HeadName: 'Audio',
                //                     ),
                //                   ),
                //                   MaterialButton(
                //                     shape: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(15),
                //                     ),
                //                     height: 60,
                //                     minWidth: 40,
                //                     color: Colors.blueAccent,
                //                     onPressed: () async {
                //                       final result =
                //                           await FilePicker.platform.pickFiles();
                //                       if (result != null) {
                //                         setState(
                //                           () {
                //                             pickaudio = result.files.first;
                //                           },
                //                         );

                //                         //the file url

                //                         final str =
                //                             await pickingFile(pickaudio!);
                //                         setState(
                //                           () {
                //                             commAudio = str;
                //                           },
                //                         );
                //                       }
                //                     },
                //                     child: const Text('Attach audio'),
                //                   ),
                //                   const SizedBox(
                //                     height: 150,
                //                   ),
                //                 ],
                //               ),
                //             );
                //           },
                //         );
                //       },
                //     );
                //   },
                //   child: const Text(
                //     'Give Resource',
                //     style: TextStyle(
                //       fontSize: 14,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                Center(
                  child: MaterialButton(
                    height: 60,
                    minWidth: 200,
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: () async {
                      setState(() {
                        isfinish = false;
                      });
                      String result = await YAuth().createCommunity(
                        commName: commName.text.trim(),
                        commLikes: [],
                        commOwner: FirebaseAuth.instance.currentUser!.uid,
                        commPicture: photolink,
                        commBio: commBio.text.trim(),
                        commRating: 0,
                        habits: habito,
                        members: [
                          {
                            'date': DateTime.now(),
                            'userId': FirebaseAuth.instance.currentUser!.uid
                          }
                        ],
                      );
                      setState(() {
                        isfinish = true;
                      });
                      if (result == 'success') {
                        Get.snackbar(
                          snackPosition: SnackPosition.BOTTOM,
                          '',
                          'Congratulation! you successfully created ${commName.text} community',
                          borderRadius: 15,
                          backgroundGradient: const LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.black,
                            ],
                          ),
                        );
                        Navigator.pop(context);
                      } else {
                        Get.snackbar(
                          snackPosition: SnackPosition.BOTTOM,
                          '',
                          'Error : Unable to create your community',
                          borderRadius: 15,
                          backgroundGradient: LinearGradient(
                            colors: [
                              Colors.red,
                              Colors.black,
                            ],
                          ),
                        );
                      }
                    },
                    child: isfinish
                        ? const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          )
                        : SizedBox(
                            width: 30,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
