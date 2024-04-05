import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

PickedImage(ImageSource source) async {
  //instance of image picker

  ImagePicker pick = ImagePicker();

  XFile? file = await pick.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }
}
