import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/components/widgets/snack_bar.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/helpers/image_handler.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/assembly_steps_feature/widgets/build_selected_images.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';
import 'package:rollshop/features/parts_with_material_number/view_model/cubit/parts_cubit.dart';
import 'package:rollshop/features/parts_with_material_number/view_model/cubit/parts_state.dart';
import 'package:rollshop/features/parts_with_material_number/widgets/build_image.dart';

import '../../../components/widgets/text_field.dart';
import '../../../core/theme/colors.dart';

class AddPartWithMaterialNumberScreen extends StatefulWidget {
  AddPartWithMaterialNumberScreen({super.key});
  AddPartWithMaterialNumberScreen.edit({
    required this.isEdit,
    required this.partModel,
  });

  bool isEdit = false;
  PartsWithMaterialNumberModel? partModel;

  @override
  State<AddPartWithMaterialNumberScreen> createState() =>
      _AddPartWithMaterialNumberScreenState();
}

class _AddPartWithMaterialNumberScreenState
    extends State<AddPartWithMaterialNumberScreen> {
  TextEditingController partNameController = TextEditingController();
  TextEditingController materialNumberController = TextEditingController();
  TextEditingController drawingPartNumberController = TextEditingController();
  TextEditingController partNotesController = TextEditingController();
  TextEditingController usageController = TextEditingController();

  // TextEditingController typeController = TextEditingController();
  // TextEditingController areaOfUsageController = TextEditingController();
  TextEditingController sizesController = TextEditingController();
  TextEditingController dropDownTypeController = TextEditingController();
  TextEditingController dropDownAreaOfUsageController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> pickedImages = [];

  final _formKey = GlobalKey<FormState>();
  // String type = "";
  String imageUrl = '';

  @override
  void initState() {
    // debugPrint("${widget.partModel!.name}");
    super.initState();
    if (widget.isEdit) {
      imageUrl = widget.partModel!.imagePath;
      debugPrint(imageUrl);
      // debugPrint("sffffffffffffffffffffffffffffffffffffffffff");
      dropDownAreaOfUsageController.text = widget.partModel!.areaOfUsage;
      dropDownTypeController.text = widget.partModel!.type;
      partNameController.text = widget.partModel!.name;
      materialNumberController.text =
          widget.partModel!.materialNumber.toString();
      drawingPartNumberController.text =
          widget.partModel!.drawingPartNumber.toString();
      partNotesController.text = widget.partModel!.notes ?? "";
      sizesController.text = widget.partModel!.sizes;
      usageController.text = widget.partModel!.usage;

      // partNameController.text = widget.partModel!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PartsCubit, PartsState>(
      listener: (context, state) {
        // if (state is PartAddeddSuccessfullyState) {
        //   showCustomSnackBar(
        //     context: context,
        //     message: 'بنجاح ${partNameController.text} تم اضافة ال ',
        //     color: ColorsManager.mainTeal,
        //   );
        // } else if (state is PartWatingState) {
        //   showCustomSnackBar(
        //     context: context,
        //     message: '${partNameController.text} جاري حفظ بيانات ال',
        //     color: ColorsManager.mainTeal,
        //   );
        // } else if (state is PartUpdatedSuccessfullyState) {
        //   showCustomSnackBar(
        //     context: context,
        //     message: 'تم التعديل بنجاح',
        //     color: ColorsManager.mainTeal,
        //   );
        // } else if (state is PartsErrorState) {
        //   showCustomSnackBar(
        //     context: context,
        //     message: state.error,
        //     color: ColorsManager.redColor,
        //   );
        // }
        if (state is PartsErrorState) {
          showCustomSnackBar(
            context: context,
            message: state.error,
            color: ColorsManager.redColor,
          );
        }
      },
      builder: (context, state) {
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
                      GestureDetector(
                        onTap: () async {
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
                          }
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorsManager.orangeColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: SizedBox(
                              width: context.width * 0.6,
                              height: context.height / 4,
                              child: pickedImages.isNotEmpty
                                  ? BuildImageWithErrorHandler(
                                      imageType: ImageType.file,
                                      path: pickedImages.first,
                                      boxFit: BoxFit.cover,
                                    )
                                  : imageUrl.isNotEmpty
                                      ? BuildImageWithErrorHandler(
                                          imageType: ImageType.network,
                                          path: imageUrl)
                                      : SizedBox(),
                            ),
                          ),
                        ),
                      ),
                      CustomTextField(
                        textFieldController: partNameController,
                        hintText: "أسم القطعة",
                      ),
                      CustomTextField(
                        textFieldController: materialNumberController,
                        hintText: "رقم ماتريال",
                        keyboardType: TextInputType.number,
                      ),
                      CustomTextField(
                        textFieldController: drawingPartNumberController,
                        hintText: "رقم القطعة في الرسمة",
                        keyboardType: TextInputType.number,
                      ),
                      // CustomTextField(
                      //   textFieldController: typeController,
                      //   hintText: "Type",
                      // ),
                      DropdownMenu(
                        controller: dropDownTypeController,
                        initialSelection:
                            widget.isEdit ? widget.partModel!.type : "Part",
                        width: context.width,
                        leadingIcon: Icon(Icons.settings_suggest_outlined),
                        inputDecorationTheme: InputDecorationTheme(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: ColorsManager.orangeColor,
                            ),
                          ),
                        ),
                        label: Text(
                          'اختر نوع القطعة',
                          style: MyTextStyles.lable18OrangeBold,
                        ),
                        dropdownMenuEntries: [
                          DropdownMenuEntry(value: "Part", label: "Part"),
                          DropdownMenuEntry(value: "Seal", label: "Seal"),
                          DropdownMenuEntry(value: "Bearing", label: "Bearing"),
                          DropdownMenuEntry(value: "Chock", label: "Chock"),
                        ],
                      ),
                      DropdownMenu(
                        controller: dropDownAreaOfUsageController,
                        initialSelection: widget.isEdit
                            ? widget.partModel!.areaOfUsage
                            : "BDM",
                        width: context.width,
                        leadingIcon: Icon(Icons.settings_suggest_outlined),
                        inputDecorationTheme: InputDecorationTheme(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: ColorsManager.orangeColor,
                            ),
                          ),
                        ),
                        label: Text(
                          'اختار منطقة الشغل',
                          style: MyTextStyles.lable18OrangeBold,
                        ),
                        dropdownMenuEntries: [
                          DropdownMenuEntry(value: "BDM", label: "BDM"),
                          DropdownMenuEntry(value: "TDM", label: "TDM"),
                          DropdownMenuEntry(
                              value: "Vertical", label: "Vertical"),
                          DropdownMenuEntry(
                              value: "Straghitner", label: "Straghitner"),
                          DropdownMenuEntry(value: "Guides", label: "Guides"),
                        ],
                      ),
                      // CustomTextField(
                      //   textFieldController: areaOfUsageController,
                      //   hintText: "Area Of Usage",
                      // ),
                      CustomTextField(
                        textFieldController: sizesController,
                        hintText: "المقاسات",
                      ),
                      CustomTextField(
                        textFieldController: usageController,
                        hintText: "الأستخدام",
                      ),
                      CustomTextField(
                        textFieldController: partNotesController,
                        hintText: "ملاحظات",
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                      ),
                      // SizedBox(
                      //   width: context.width * 0.8,
                      //   child: DecoratedBox(
                      //     decoration: BoxDecoration(
                      //       color: ColorsManager.orangeColor,
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //     child: TextButton(
                      //       onPressed: () async {
                      //         try {
                      //           XFile? image = await _imagePicker.pickImage(
                      //               source: ImageSource.gallery);
                      //           if (image != null) {
                      //             setState(() {
                      //               pickedImages = [image];
                      //             });
                      //           }
                      //         } catch (e) {
                      //           debugPrint('Error picking images: $e');
                      //           // Handle the error, e.g., show a snackbar
                      //           showCustomSnackBar(
                      //             context: context,
                      //             message: "Error picking images: $e",
                      //             color: ColorsManager.orangeColor,
                      //           );
                      //           // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //           //     content: Text('Error picking images: $e')));
                      //         }
                      //       },
                      //       child: Text(
                      //         "Upload Image For Part",
                      //         style: MyTextStyles.font16WhiteBold,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // pickedImages.isNotEmpty
                      //     ? BuildImage(image: pickedImages.first)
                      //     : SizedBox(),
                      CustomButton(
                        buttonName: 'حفظ',
                        color: ColorsManager.orangeColor,
                        onPressed: () async {
                          if (!_formKey.currentState!.validate() ||
                              (pickedImages.isEmpty && imageUrl.isEmpty)) {
                            debugPrint(pickedImages.length.toString());
                            debugPrint(partNameController.text);
                            showCustomSnackBar(
                              context: context,
                              message: "برجاء ادخال جميع البيانات",
                              color: ColorsManager.redColor,
                            );
                            debugPrint("image url is: $imageUrl in validate");
                            return;
                          } else if (_formKey.currentState!.validate()) {
                            await onSubmit();
                            if (widget.isEdit) {
                              // pickedImages
                              PartsCubit.get(context).updatePart(
                                part: PartsWithMaterialNumberModel(
                                  name: partNameController.text,
                                  materialNumber:
                                      int.parse(materialNumberController.text),
                                  type: dropDownTypeController.text,
                                  usage: usageController.text,
                                  imagePath: imageUrl,
                                  drawingPartNumber: int.parse(
                                      drawingPartNumberController.text),
                                  areaOfUsage:
                                      dropDownAreaOfUsageController.text,
                                  sizes: sizesController.text,
                                  notes: partNotesController.text.isEmpty
                                      ? ""
                                      : partNotesController.text,
                                ),
                                id: widget.partModel!.id.toString(),
                              );
                            } else {
                              PartsCubit.get(context).addOnePart(
                                part: PartsWithMaterialNumberModel(
                                  name: partNameController.text,
                                  materialNumber:
                                      int.parse(materialNumberController.text),
                                  type: dropDownTypeController.text,
                                  usage: usageController.text,
                                  imagePath: imageUrl,
                                  drawingPartNumber: int.parse(
                                      drawingPartNumberController.text),
                                  areaOfUsage:
                                      dropDownAreaOfUsageController.text,
                                  sizes: sizesController.text,
                                  notes: partNotesController.text.isEmpty
                                      ? ""
                                      : partNotesController.text,
                                ),
                              );
                            }
                          }
                        },
                      ),
                      CustomButton(
                        buttonName: 'حذف هذا العنصر',
                        color: ColorsManager.redColor,
                        onPressed: () async {
                          await PartsCubit.get(context)
                              .deletePart(id: widget.partModel!.id.toString());
                          showCustomSnackBar(
                            context: context,
                            message: "تم حذف العنصر بنجاح",
                            color: ColorsManager.mainTeal,
                          );
                          context.pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> onSubmit() async {
    // Make onSubmit async
    if (imageUrl.isEmpty && pickedImages.isEmpty) {
      showCustomSnackBar(
        context: context,
        message: "Please pick part image",
        color: ColorsManager.redColor,
      );
      return; // Important: Return early if no image is picked
    }

    try {
      String? value = await ImageHandler().uploadImageToImgur(
        File(pickedImages.first.path),
      ); // Use await here

      if (value != null) {
        setState(() {
          imageUrl = value; // Assign the value directly
          debugPrint(imageUrl);
          // debugPrint("$imageUrl after added in await block");
        });
      } else {
        showCustomSnackBar(
          context: context,
          message: "Image upload failed. Please try again.",
          color: ColorsManager.redColor,
        );
        debugPrint("Image upload returned null");
      }
    } catch (onError) {
      showCustomSnackBar(
        context: context,
        message: "An error occurred during upload: ${onError.toString()}",
        color: ColorsManager.redColor,
      );
      debugPrint("Error during upload: $onError");
    }
  }
}
