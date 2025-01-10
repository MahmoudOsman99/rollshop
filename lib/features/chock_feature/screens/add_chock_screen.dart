import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/components/widgets/snack_bar.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';

import '../../../components/widgets/text_field.dart';
import '../widgets/build_selected_images.dart';

class AddChockScreen extends StatefulWidget {
  AddChockScreen({super.key});

  @override
  State<AddChockScreen> createState() => _AddChockScreenState();
}

class _AddChockScreenState extends State<AddChockScreen> {
  TextEditingController chockNameController = TextEditingController();
  TextEditingController chockDescriptionController = TextEditingController();
  TextEditingController chockNotesController = TextEditingController();

  List<XFile> pickedImages = [];

  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 50.sp,
            left: 10.sp,
            right: 10.sp,
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                CustomTextFormField(
                  textFieldController: chockNameController,
                  hintText: "أسم الكرسي",
                ),
                CustomTextFormField(
                  textFieldController: chockNotesController,
                  hintText: "ملاحظات",
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                ),
                SizedBox(
                  width: context.width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: ColorsManager.orangeColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        try {
                          List<XFile>? images =
                              await _imagePicker.pickMultiImage();
                          if (images.isNotEmpty) {
                            setState(() {
                              pickedImages = images;
                            });
                          }
                        } catch (e) {
                          debugPrint('Error picking images: $e');
                          // Handle the error, e.g., show a snackbar
                          showCustomSnackBar(
                            context: context,
                            message: "Error picking images: $e",
                            color: ColorsManager.orangeColor,
                          );
                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     content: Text('Error picking images: $e')));
                        }
                      },
                      child: Text(
                        "اختار صور خطوات التجميع",
                        style: MyTextStyles.font16WhiteBold,
                      ),
                    ),
                  ),
                ),
                pickedImages.isNotEmpty
                    ? BuildSelectedImages(
                        itemCount: pickedImages.length,
                        images: pickedImages,
                      )
                    : SizedBox(),
                CustomTextFormField(
                  textFieldController: chockDescriptionController,
                  hintText: "شرح طريقة التجميع",
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                ),
                CustomButton(
                  buttonName: 'Upload',
                  color: ColorsManager.orangeColor,
                  onPressed: () {
                    debugPrint(chockNameController.text);
                    debugPrint(chockNotesController.text);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
