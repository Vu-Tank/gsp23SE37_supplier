import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> uploadFileChat(Uint8List file, String fileName) async {
    try {
      Reference storageRef = storage.ref();
      Reference imagesRef = storageRef.child('imagesChat/$fileName');
      // await imagesRef.putFile(file);
      await imagesRef.putData(file);
      String? urlDownload = await imagesRef.getDownloadURL();
      return urlDownload;
    } on FirebaseException {
      return null;
    }
  }

  Future<String?> loadFile(String? fileName) async {
    String? url;
    try {
      if (fileName == null) {
        return url;
      } else {
        Reference storageRef = storage.ref();
        Reference urlRef = storageRef.child('images').child(fileName);
        url = await urlRef.getDownloadURL();
        return url;
      }
    } catch (e) {
      return url;
    }
  }

  Future<void> deleteFile(String fileName) async {
    Reference storageRef = storage.ref();
    Reference urlRef = storageRef.child('images').child(fileName);
    await urlRef.delete();
  }

  Future<String?> uploadFileVideo(Uint8List file, String fileName) async {
    try {
      Reference storageRef = storage.ref();
      Reference imagesRef = storageRef.child('video/$fileName');
      // await imagesRef.putFile(file);
      await imagesRef.putData(file);
      String? urlDownload = await imagesRef.getDownloadURL();
      return urlDownload;
    } on FirebaseException {
      rethrow;
    }
  }
}
