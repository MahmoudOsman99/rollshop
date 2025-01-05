import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/components/widgets/snack_bar.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/assembly_steps_feature/widgets/build_selected_images.dart';
import 'package:rollshop/features/parts_with_material_number/widgets/build_image.dart';

import '../../../components/widgets/text_field.dart';
import '../../../core/theme/colors.dart';

class AddPartWithMaterialNumberScreen extends StatefulWidget {
  AddPartWithMaterialNumberScreen({super.key});

  @override
  State<AddPartWithMaterialNumberScreen> createState() =>
      _AddPartWithMaterialNumberScreenState();
}

class _AddPartWithMaterialNumberScreenState
    extends State<AddPartWithMaterialNumberScreen> {
  TextEditingController partNameController = TextEditingController();
  TextEditingController materialNumberController = TextEditingController();
  TextEditingController partNotesController = TextEditingController();
  TextEditingController usageController = TextEditingController();

  TextEditingController typeController = TextEditingController();
  TextEditingController areaOfUsageController = TextEditingController();
  TextEditingController sizesController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> pickedImages = [];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 50.sp,
            left: 10.sp,
            right: 10.sp,
            bottom: 30.sp,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 20,
                children: [
                  CustomTextField(
                    textFieldController: partNameController,
                    hintText: "Part Name",
                  ),
                  CustomTextField(
                    textFieldController: materialNumberController,
                    hintText: "Material Number",
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextField(
                    textFieldController: typeController,
                    hintText: "Type",
                  ),
                  CustomTextField(
                    textFieldController: areaOfUsageController,
                    hintText: "Area Of Usage",
                  ),
                  CustomTextField(
                    textFieldController: usageController,
                    hintText: "Usage",
                  ),
                  CustomTextField(
                    textFieldController: partNotesController,
                    hintText: "Notes",
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                  ),
                  SizedBox(
                    width: context.width * 0.8,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: ColorsManager.orangeColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          try {
                            XFile? image = await _imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              setState(() {
                                pickedImages = [image];
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
                          "Upload Image For Part",
                          style: MyTextStyles.font16WhiteBold,
                        ),
                      ),
                    ),
                  ),
                  pickedImages.isNotEmpty
                      ? BuildImage(image: pickedImages.first)
                      : SizedBox(),
                  CustomButton(
                    buttonName: 'Save',
                    color: ColorsManager.orangeColor,
                    onPressed: () {
                      _formKey.currentState!.validate();
                      // debugPrint(chockNameController.text);
                      // debugPrint(chockNotesController.text);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
