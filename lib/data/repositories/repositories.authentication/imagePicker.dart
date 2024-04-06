import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

PickedImage(ImageSource source) async {
  //instance of image picker

  ImagePicker pick = ImagePicker();

  XFile? file = await pick.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }
}

Future<String> pickingFile(PlatformFile f) async {
  try {
    final files = File(
      f.path!,
    );
    final ref = FirebaseStorage.instance.ref().child('community file');
    UploadTask task = ref.putFile(files);
    // final snap = await task.whenComplete(() => null);
    TaskSnapshot snap = await task;
    final str = snap.ref.getDownloadURL();
    return str;
  } catch (e) {
    return e.toString();
  }
}
