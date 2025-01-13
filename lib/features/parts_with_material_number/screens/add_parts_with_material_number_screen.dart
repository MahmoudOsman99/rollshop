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
import 'package:rollshop/core/router/app_router.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';
import 'package:rollshop/features/parts_with_material_number/view_model/cubit/parts_cubit.dart';
import 'package:rollshop/features/parts_with_material_number/view_model/cubit/parts_state.dart';

import '../../../components/widgets/custom_text_field.dart';
import '../../../core/theme/colors.dart';

class AddPartWithMaterialNumberScreen extends StatefulWidget {
  AddPartWithMaterialNumberScreen({super.key, required this.isEdit});
  AddPartWithMaterialNumberScreen.edit({
    required this.isEdit,
    required this.partModel,
    // required this.isViewOnly,
  });

  bool isEdit = false;
  // bool isViewOnly = false;
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

  bool isSaveLoading = false;
  bool isDeleteLoading = false;

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
                          // if (widget.isViewOnly) return;
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
                              child: imageUrl != null && imageUrl!.isNotEmpty
                                  ? BuildImageWithErrorHandler(
                                      imageType: ImageType.network,
                                      path: imageUrl,
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
                        // isReadOnly: widget.isViewOnly,
                      ),
                      CustomTextFormField(
                        textFieldController: materialNumberController,
                        hintText: "رقم ماتريال",
                        keyboardType: TextInputType.number,
                        // isReadOnly: widget.isViewOnly,
                      ),
                      CustomTextFormField(
                        textFieldController: drawingPartNumberController,
                        hintText: "رقم القطعة في الرسمة",
                        keyboardType: TextInputType.number,
                        // isReadOnly: widget.isViewOnly,
                      ),
                      DropdownMenu(
                        controller: dropDownTypeController,
                        initialSelection:
                            widget.isEdit ? widget.partModel!.type : "Part",
                        width: context.width,
                        // enabled: !widget.isViewOnly,
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
                          menuEntry("Part"),
                          menuEntry("Seal"),
                          menuEntry("Bearing"),
                          menuEntry("Chock"),
                          menuEntry("Guide"),
                          menuEntry("Roll"),

                          // DropdownMenuEntry(value: "Part", label: "Part"),
                          // DropdownMenuEntry(value: "Seal", label: "Seal"),
                          // DropdownMenuEntry(value: "Bearing", label: "Bearing"),
                          // DropdownMenuEntry(value: "Chock", label: "Chock"),
                        ],
                      ),
                      CustomDropDown(
                        dropDownController: dropDownAreaOfUsageController,
                        part: widget,
                        mainLable: 'اختار منطقة الشغل',
                        initialSelection: "BDM",
                        items: [
                          menuEntry("BDM"),
                          menuEntry("TDM"),
                          menuEntry("Vertical"),
                          menuEntry("Straghitner"),
                          menuEntry("Guides"),
                          // DropdownMenuEntry(value: "BDM", label: "BDM"),
                          // DropdownMenuEntry(value: "TDM", label: "TDM"),
                          // DropdownMenuEntry(
                          //     value: "Vertical", label: "Vertical"),
                          // DropdownMenuEntry(
                          //     value: "Straghitner", label: "Straghitner"),
                          // DropdownMenuEntry(value: "Guides", label: "Guides"),
                        ],
                      ),
                      CustomTextFormField(
                        textFieldController: sizesController,
                        hintText: "المقاسات",
                        // isReadOnly: widget.isViewOnly,
                      ),
                      CustomTextFormField(
                        textFieldController: usageController,
                        hintText: "الأستخدام",
                        // isReadOnly: widget.isViewOnly,
                      ),
                      CustomTextFormField(
                        textFieldController: partNotesController,
                        hintText: "ملاحظات",
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        isRequired: false,
                        // isReadOnly: widget.isViewOnly,
                      ),
                      isSaveLoading
                          ? CircularProgressIndicator()
                          : CustomButton(
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
                                    setState(() {
                                      isSaveLoading = true;
                                    });
                                    if (await context
                                        .read<PartsCubit>()
                                        .isPartExistByMaterialNumber(
                                            materialNumber: int.parse(
                                                materialNumberController
                                                    .text))) {
                                      setState(() {
                                        isSaveLoading = false;
                                      });
                                      showCustomSnackBar(
                                        context: context,
                                        message:
                                            "تم تسجيل هذا العنصر بنفس رقم material number من قبل",
                                        color: ColorsManager.redColor,
                                      );
                                      return;
                                    }
                                    imageUrl = await uploadImageToImgur(
                                        imageFile: imageFile);
                                    if (imageUrl == null) {
                                      showCustomSnackBar(
                                        context: context,
                                        message: "حدث مشكلة اثناء حفظ الصورة",
                                        color: ColorsManager.redColor,
                                      );
                                      return;
                                    }
                                    // CircularProgressIndicator();
                                    setState(() {
                                      isSaveLoading = true;
                                    });
                                    sl<PartsCubit>().addOnePart(
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
                                    setState(() {
                                      isSaveLoading = false;
                                    });
                                    showCustomSnackBar(
                                      context: context,
                                      message: "تم الحفظ بنجاح",
                                      color: ColorsManager.mainTeal,
                                    );
                                    context.pop();
                                  }
                                  // else {
                                  //   isLoading = false;
                                  //   showCustomSnackBar(
                                  //     context: context,
                                  //     message:
                                  //         "تم تسجيل هذا العنصر بنفس رقم material number من قبل",
                                  //     color: ColorsManager.mainTeal,
                                  //   );
                                  //   return;
                                  // }

                                  // if (imageFile != null) {
                                  //   imageUrl = await uploadImageToImgur(
                                  //     imageFile: imageFile,
                                  //   );
                                  // }
                                  // sl<PartsCubit>().updatePart(
                                  //   part: PartsWithMaterialNumberModel(
                                  //     name: partNameController.text,
                                  //     materialNumber: int.parse(
                                  //         materialNumberController.text),
                                  //     type: dropDownTypeController.text,
                                  //     usage: usageController.text,
                                  //     imagePath: imageUrl ?? "",
                                  //     drawingPartNumber: int.parse(
                                  //         drawingPartNumberController.text),
                                  //     areaOfUsage:
                                  //         dropDownAreaOfUsageController.text,
                                  //     sizes: sizesController.text,
                                  //     notes: partNotesController.text.isEmpty
                                  //         ? ""
                                  //         : partNotesController.text,
                                  //   ),
                                  //   id: widget.partModel!.id.toString(),
                                  // );
                                  // setState(() {
                                  //   isLoading = false;
                                  // });
                                }
                              },
                            ),
                      widget.isEdit
                          ? !isDeleteLoading
                              ? CustomButton(
                                  buttonName: 'حذف هذا العنصر',
                                  color: ColorsManager.redColor,
                                  onPressed: () async {
                                    setState(() {
                                      isDeleteLoading = true;
                                    });
                                    final result = await showDialog<bool>(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('تأكيد الحذف'),
                                          content: Text(
                                              'هل تريد حذف هذا العنصر ${partNameController.text}?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => context
                                                  .pop(), // Return false//////////////////////////
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
                                      await context
                                          .read<PartsCubit>()
                                          .deletePart(
                                            id: widget.partModel!.id!,
                                          );
                                      showCustomSnackBar(
                                        context: context,
                                        message: "تم حذف العنصر بنجاح",
                                        color: ColorsManager.redColor,
                                      );
                                      setState(() {
                                        isDeleteLoading = false;
                                      });
                                      context.pop();
                                    } else {
                                      showCustomSnackBar(
                                        context: context,
                                        message: "لم يتم الحذف",
                                        color: ColorsManager.mainTeal,
                                      );
                                      setState(() {
                                        isDeleteLoading = false;
                                      });
                                    }
                                  })
                              : CircularProgressIndicator()
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

  void savePart(
      {required PartsWithMaterialNumberModel part,
      required PartProccessType type}) {}

  Future<String?> uploadImageToImgur({required File? imageFile}) async {
    // debugPrint("in onsubmit");
    // debugPrint("imageurl: $imageUrl --- imagefile: ${imageFile!.path}");

    if (imageFile == null) return null;
    // Make onSubmit async
    // debugPrint("imageurl: $imageUrl --- imagefile: ${imageFile.path}");
    try {
      String? value = await ImageHandler().uploadImageToImgur(
        File(imageFile.path),
      ); // Use await here
      debugPrint("$value");
      return value;

      // if (value != null) {
      //   // setState(() {
      //   // imageUrl = value; // Assign the value directly
      //   // debugPrint(imageUrl);
      //   // debugPrint("$imageUrl after added in await block");
      //   // });
      // } else {
      //   showCustomSnackBar(
      //     context: context,
      //     message: "Image upload failed. Please try again.",
      //     color: ColorsManager.redColor,
      //   );
      //   debugPrint("Image upload returned null");
      //   return null;
      // }
    } catch (onError) {
      showCustomSnackBar(
        context: context,
        message: "An error occurred during upload: ${onError.toString()}",
        color: ColorsManager.redColor,
      );
      debugPrint("Error during upload: $onError");
    }
    // debugPrint("$imageUrl after upload");
    return null;
  }
}

DropdownMenuEntry menuEntry(
  String lable,
) =>
    DropdownMenuEntry(
      value: lable,
      label: lable,
    );

class CustomDropDown extends StatelessWidget {
  CustomDropDown({
    super.key,
    this.dropDownController,
    this.part,
    required this.items,
    required this.mainLable,
    required this.initialSelection,
    this.onSelected,
  });

  final TextEditingController? dropDownController;
  final AddPartWithMaterialNumberScreen? part;
  List<DropdownMenuEntry> items;
  String mainLable;
  String initialSelection;
  ValueChanged<dynamic>? onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      controller: dropDownController,
      initialSelection: initialSelection,
      // initialSelection: part.isEdit ? part.partModel!.areaOfUsage : "BDM",
      width: context.width,
      onSelected: onSelected,
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
        mainLable,
        style: MyTextStyles.lable18OrangeBold,
      ),
      dropdownMenuEntries: [
        ...items
        // DropdownMenuEntry(value: "BDM", label: "BDM"),
        // DropdownMenuEntry(value: "TDM", label: "TDM"),
        // DropdownMenuEntry(value: "Vertical", label: "Vertical"),
        // DropdownMenuEntry(value: "Straghitner", label: "Straghitner"),
        // DropdownMenuEntry(value: "Guides", label: "Guides"),
      ],
    );
  }
}

enum PartProccessType {
  add,
  update,
  delete,
}
