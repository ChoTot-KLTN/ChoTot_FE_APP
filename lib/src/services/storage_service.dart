import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  Future<String> uploadFileToStorage(String path) async {
    String fileName = DateTime.now().toString();
    Reference ref =
        FirebaseStorage.instance.ref().child('Avatars').child(fileName);
    UploadTask uploadTask = ref.putFile(File(path));
    TaskSnapshot snapshot = await uploadTask;
    var downUrl = await snapshot.ref.getDownloadURL();
    String url = downUrl.toString();
    print("download success: " + url);
    return url;
  }
}
