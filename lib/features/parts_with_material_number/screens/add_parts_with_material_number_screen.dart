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
  AddPartWithMaterialNumberScreen({super.key, required this.isEdit});
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
  // List<XFile> pickedImages = [];
  File? imageFile;

  final _formKey = GlobalKey<FormState>();
  // String type = "";
  String? imageUrl;

  @override
  void initState() {
    // debugPrint("${widget.partModel!.name}");
    super.initState();
    // if (widget.isEdit == false) {
    //   imageUrl = "";
    // }
    if (widget.isEdit) {
      if (widget.partModel!.imagePath.isNotEmpty) {
        imageUrl = widget.partModel!.imagePath;
      } else {
        imageUrl = null;
      }
      debugPrint(imageUrl);
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
    }
    debugPrint("------------- is edit is: ${widget.isEdit} -----------");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PartsCubit, PartsState>(
      listener: (context, state) {
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
                            XFile? pickedImage = await _imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (pickedImage != null) {
                              setState(() {
                                imageFile = File(pickedImage.path);
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
                              width: context.width * 0.7,
                              height: context.height / 3,
                              child: imageUrl != null
                                  ? BuildImageWithErrorHandler(
                                      imageType: ImageType.file,
                                      path: imageFile,
                                    )
                                  : imageFile != null
                                      ? BuildImageWithErrorHandler(
                                          imageType: ImageType.file,
                                          path: imageFile,
                                        )
                                      : SizedBox(
                                          child: Icon(
                                            Icons.upload,
                                            size: 100,
                                            color: ColorsManager.orangeColor,
                                          ),
                                        ),
                            ),
                            // !widget.isEdit && imageFile != null
                            //     ? BuildImageWithErrorHandler(
                            //         imageType: ImageType.file, path: imageFile)
                            //     : SizedBox(),
                            //  widget.isEdit &&
                            //         (imageUrl == null || imageUrl!.isEmpty)
                            //     ? BuildImageWithErrorHandler(
                            //             imageType: ImageType.file,
                            //             path: imageFile,
                            //           )
                            //     : imageFile != null
                            //         ? BuildImageWithErrorHandler(
                            //         imageType: ImageType.network,
                            //         path: imageUrl,
                            //       )
                            //         : SizedBox(),
                            // SizedBox(
                            //   width: context.width * 0.7,
                            //   height: context.height / 3,
                            //   child: widget.isEdit
                            //       ? imageUrl.isNotEmpty
                            //           ? BuildImageWithErrorHandler(
                            //               imageType: ImageType.network,
                            //               path: imageUrl,
                            //             )
                            //           : SizedBox()
                            //       : BuildImageWithErrorHandler(
                            //           imageType: ImageType.file,
                            //           path: imageFile,
                            //         ),
                            // ),
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        textFieldController: partNameController,
                        hintText: "أسم القطعة",
                      ),
                      CustomTextFormField(
                        textFieldController: materialNumberController,
                        hintText: "رقم ماتريال",
                        keyboardType: TextInputType.number,
                      ),
                      CustomTextFormField(
                        textFieldController: drawingPartNumberController,
                        hintText: "رقم القطعة في الرسمة",
                        keyboardType: TextInputType.number,
                      ),
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
                      CustomTextFormField(
                        textFieldController: sizesController,
                        hintText: "المقاسات",
                      ),
                      CustomTextFormField(
                        textFieldController: usageController,
                        hintText: "الأستخدام",
                      ),
                      CustomTextFormField(
                        textFieldController: partNotesController,
                        hintText: "ملاحظات",
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        isRequired: false,
                      ),
                      CustomButton(
                        buttonName: 'حفظ',
                        color: ColorsManager.orangeColor,
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            showCustomSnackBar(
                              context: context,
                              message: "برجاء ادخال جميع البيانات",
                              color: ColorsManager.redColor,
                            );
                          } else {
                            if (widget.isEdit == false) {
                              if (imageFile == null) {
                                showCustomSnackBar(
                                  context: context,
                                  message: "برجاء اختيار صورة",
                                  color: ColorsManager.redColor,
                                );
                                return;
                              }
                              final isPartExistByMaterialNumber =
                                  await PartsCubit.get(context)
                                      .searchOnePartByMaterialNumber(
                                          materialNumber:
                                              materialNumberController.text
                                                  .toString());

                              if (!isPartExistByMaterialNumber) {
                                await uploadImageToImgur();
                                if (imageUrl == null) {
                                  showCustomSnackBar(
                                    context: context,
                                    message: "حدث مشكلة اثناء حفظ الصورة",
                                    color: ColorsManager.redColor,
                                  );
                                  return;
                                }
                                PartsCubit.get(context).addOnePart(
                                  part: PartsWithMaterialNumberModel(
                                    name: partNameController.text,
                                    materialNumber: int.parse(
                                        materialNumberController.text),
                                    type: dropDownTypeController.text,
                                    usage: usageController.text,
                                    imagePath: imageUrl ?? "",
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
                                showCustomSnackBar(
                                  context: context,
                                  message: "تم حفظ العنصر بنجاح",
                                  color: ColorsManager.mainTeal,
                                );
                              } else {
                                showCustomSnackBar(
                                  context: context,
                                  message:
                                      "تم تسجيل هذا العنصر بنفس رقم material number من قبل",
                                  color: ColorsManager.mainTeal,
                                );
                                return;
                              }
                            } else {
                              // imageUrl = await onSubmit();

                              // onSubmit();
                              if (widget.isEdit) {
                                // pickedImages
                                PartsCubit.get(context).updatePart(
                                  part: PartsWithMaterialNumberModel(
                                    name: partNameController.text,
                                    materialNumber: int.parse(
                                        materialNumberController.text),
                                    type: dropDownTypeController.text,
                                    usage: usageController.text,
                                    imagePath: imageUrl ?? "",
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
                              } else {}
                            }
                          }
                        },
                      ),
                      widget.isEdit
                          ? CustomButton(
                              buttonName: 'حذف هذا العنصر',
                              color: ColorsManager.redColor,
                              onPressed: () async {
                                final isExist = await PartsCubit.get(context)
                                    .searchOnePartByMaterialNumber(
                                        materialNumber: widget
                                            .partModel!.materialNumber
                                            .toString());
                                if (isExist) {
                                  final result = await showDialog<bool>(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('تأكيد الحذف'),
                                        content: Text(
                                            'هل تريد حذف هذا العنصر ${partNameController.text}?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false), // Return false
                                            child: const Text('الغاء'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(true), // Return true
                                            child: const Text(
                                              'تأكيد',
                                              style: TextStyle(
                                                color: ColorsManager.redColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if (result == true) {
                                    await PartsCubit.get(context).deletePart(
                                        id: widget.partModel!.id.toString());
                                    showCustomSnackBar(
                                      context: context,
                                      message: "تم حذف العنصر بنجاح",
                                      color: ColorsManager.redColor,
                                    );
                                    context.pop();
                                  } else {
                                    showCustomSnackBar(
                                      context: context,
                                      message: "لم يتم الحذف",
                                      color: ColorsManager.mainTeal,
                                    );
                                  }
                                } else {
                                  showCustomSnackBar(
                                    context: context,
                                    message:
                                        "لا يوجد عنصر مسجل برقم material number ${widget.partModel!.materialNumber.toString()}",
                                    color: ColorsManager.mainTeal,
                                  );
                                }

                                // await PartsCubit.get(context).searchOnePart(
                                //     id: widget.partModel!.id.toString());
                              },
                            )
                          : SizedBox(),
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

  Future<String?> uploadImageToImgur() async {
    // debugPrint("in onsubmit");
    // debugPrint("imageurl: $imageUrl --- imagefile: ${imageFile!.path}");

    if (imageFile == null) return null;
    // Make onSubmit async
    debugPrint("imageurl: $imageUrl --- imagefile: ${imageFile!.path}");
    try {
      String? value = await ImageHandler().uploadImageToImgur(
        File(imageFile!.path),
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
    return null;
  }
}
