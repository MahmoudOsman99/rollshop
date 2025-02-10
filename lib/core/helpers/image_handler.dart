import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/foundation.dart' show kIsWeb;

class ImageHandler {
  /** 
   * maxWidth: if the number is big, you can use it in large image size
   *
   */
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(File imageFile,
      {int quality = 85, required int maxWidth, required int maxHeight}) async {
    try {
      File? compressedFile = await _compressAndResizeImage(
          imageFile, maxWidth, maxHeight, quality);
      if (compressedFile == null) {
        return null; // Compression failed or web platform
      }

      final storageRef = _storage
          .ref()
          .child("images/${DateTime.now().millisecondsSinceEpoch}.jpg");
      await storageRef.putFile(compressedFile);
      return await storageRef.getDownloadURL();
    } on FirebaseException catch (e) {
      debugPrint("Firebase Storage Error: $e");
      return null;
    } catch (e) {
      debugPrint("Error uploading image: $e");
      return null;
    }
  }

  Future<File?> _compressAndResizeImage(
      File file, int targetWidth, int targetHeight, int quality) async {
    if (kIsWeb) return null;

    // final appDir = await path_provider.getApplicationDocumentsDirectory();
    final filePath = file.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.(jpg|jpeg|png|gif|bmp)'));
    if (lastIndex == -1) return null;

    final splitted = filePath.substring(0, lastIndex);
    final outPath = "${splitted}compressed.jpg";

    final XFile? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      minWidth: targetWidth,
      minHeight: targetHeight,
      quality: quality,
    );

    if (result == null) {
      return null;
    }
    return File(result.path);
  }

  // Client ID: 191cf4f3d4a62a1
  // Client secret: fc30989e5c110b2bdff6ad8d0a2308fea86f49a3
  Future<String?> uploadImageToImgur(File imageFile) async {
    final url = Uri.parse('https://api.imgur.com/3/image');
    final image = await _compressAndResizeImage(imageFile, 1920, 1080, 80);
    final bytes = await image?.readAsBytes();

    final response = await http.post(
      url,
      headers: {
        'Authorization':
            'Client-ID 191cf4f3d4a62a1', // Replace with your Client ID
      },
      body: {'image': base64Encode(bytes!)},
    );
    // debugPrint(response.body['data']['link']);
    // final jsonResponse2 = jsonDecode(response.body);
    // debugPrint(jsonResponse2['data']['link']);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['data']['link'];
    } else {
      debugPrint('Imgur upload failed with status: ${response.statusCode}');
      debugPrint(
          'Response body: ${response.body}'); // Print the response for debugging
      return null;
    }
  }
}
  // Future<File?> compressAndResizeImage(
  //     File file, int targetWidth, int targetHeight, int quality) async {
  //   if (kIsWeb) return null; // No File on web

  //   // final appDir = await path_provider.getApplicationDocumentsDirectory();
  //   final filePath = file.path;
  //   final lastIndex = filePath.lastIndexOf(RegExp(r'.jp')); // Correct regex
  //   final splitted = filePath.substring(0, lastIndex);
  //   final outPath = "${splitted}compressed.jpg";

  //   final XFile? result = await FlutterImageCompress.compressAndGetFile(
  //     file.absolute.path,
  //     outPath,
  //     minWidth: targetWidth, // No need for .toInt()
  //     minHeight: targetHeight, // No need for .toInt()
  //     quality: quality,
  //   );

  //   if (result == null) {
  //     return null;
  //   }
  //   return File(result.path);
  // }

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

  // static Future<Object> _pickImage() async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     return File(pickedFile.path);
  //   } else {
  //     debugPrint('No image selected.');
  //     return "";
  //   }
  // }

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
// }
