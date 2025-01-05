import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/foundation.dart' show kIsWeb;

class ImageHandler {
  Future<File?> compressAndResizeImage(
      File file, int targetWidth, int targetHeight, int quality) async {
    if (kIsWeb) return null; // No File on web

    // final appDir = await path_provider.getApplicationDocumentsDirectory();
    final filePath = file.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp')); // Correct regex
    final splitted = filePath.substring(0, lastIndex);
    final outPath = "${splitted}compressed.jpg";

    final XFile? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      minWidth: targetWidth, // No need for .toInt()
      minHeight: targetHeight, // No need for .toInt()
      quality: quality,
    );

    if (result == null) {
      return null;
    }
    return File(result.path);
  }

//Usage
// File? compressedFile = await compressAndResizeImage(_image!, 500, 500, 85);
// if (compressedFile != null){
//     //Use the compressed file
// }

//   // Create a storage reference from our app
// final storageRef = FirebaseStorage.instance.ref();

// // Create a child reference
// final imagesRef = storageRef.child("images");
  // Create a storage reference from our app
  // final FirebaseStorage storage = FirebaseStorage.instance;

  // // Create a child reference
  // final CollectionReference imagesRef = storage.ref().child('images');

  // final FirebaseStorage storage = FirebaseStorage.instance;

  // // Storage Reference (for storing images)
  // final Reference imagesStorageRef =
  //     FirebaseStorage.instance.ref().child('images');

  // // Firestore Collection Reference (for storing image metadata)
  // final CollectionReference imagesCollectionRef =
  //     FirebaseFirestore.instance.collection('images');

  static Future<Object> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      debugPrint('No image selected.');
      return "";
    }
  }

  // static Future<void> _uploadImage(File _image) async {
  //   if (_image == null) return;
  //   final storageRef = FirebaseStorage.instance
  //       .ref()
  //       .child("images/${DateTime.now().millisecondsSinceEpoch}.jpg");
  //   try {
  //     await storageRef.putFile(_image!);
  //     _downloadUrl = await storageRef.getDownloadURL();
  //     // setState(() {});
  //     print("File Uploaded");
  //   } on FirebaseException catch (e) {
  //     print("Error uploading file: $e");
  //   }
  // }
}
