import 'package:image_picker/image_picker.dart';

class ImageModel {
  int index;
  String path;
  ImagePicker? picker;

  ImageModel({required this.index, required this.path, this.picker});
}
