import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

FirebaseStorage _storage = FirebaseStorage.instance;
Future<String> storageMethods(
  Uint8List file,
) async {
  String yara = Uuid().v1();
  Reference ref = await _storage
      .ref()
      .child('postPhoto')
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child(yara);
  UploadTask upload = ref.putData(file);
  TaskSnapshot task = await upload;
  String link = await task.ref.getDownloadURL();

  return link;
}
