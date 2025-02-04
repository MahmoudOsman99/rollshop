import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/components/widgets/custom_app_bar.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/components/widgets/custom_drop_down_menu.dart';
import 'package:rollshop/components/widgets/snack_bar.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/helpers/image_handler.dart';
import 'package:rollshop/core/router/app_router.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';
import 'package:rollshop/features/parts_with_material_number/cubit/parts_cubit.dart';
import 'package:rollshop/features/parts_with_material_number/cubit/parts_state.dart';

import '../../../components/widgets/custom_text_field.dart';
import '../../../core/theme/colors.dart';

class AddPartWithMaterialNumberScreen extends StatefulWidget {
  AddPartWithMaterialNumberScreen({super.key, required this.isEdit});
  AddPartWithMaterialNumberScreen.edit({
    super.key,
    required this.isEdit,
    required this.partModel,
    // required this.isViewOnly,
  });

  // bool allowEdit = false;
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
    // final bottom = MediaQuery.of(context).viewInsets.bottom;
    // final double screenHeight = MediaQuery.of(context).size.height;
    // final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
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
          // resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            title: Text(
              translatedText(
                context: context,
                arabicText: "آضافة عنصر جديد",
                englishText: "Add New Part",
              ),
              style: MyTextStyles.font24Weight700(Theme.of(context)),
            ),
            isCenteredTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.only(
              top: 50.r,
              left: 10.r,
              right: 10.r,
              // bottom: screenHeight - keyboardHeight,
              // bottom: 30.r,
              // bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    widget.isEdit
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 20.w,
                            children: [
                              Text(
                                translatedText(
                                  context: context,
                                  arabicText: "تعديل",
                                  englishText: "Edit",
                                ),
                                // "تعديل",
                                style:
                                    MyTextStyles.font16Bold(Theme.of(context)),
                              ),
                              Switch.adaptive(
                                  value: context.read<PartsCubit>().allowEdit,
                                  activeColor: context
                                              .read<AppCubit>()
                                              .currentThemeMode ==
                                          ThemeMode.dark
                                      ? ColorsManager.redAccent
                                      : ColorsManager.whiteColor,
                                  activeTrackColor: context
                                              .read<AppCubit>()
                                              .currentThemeMode ==
                                          ThemeMode.dark
                                      ? ColorsManager.whiteColor
                                      : ColorsManager.orangeColor,
                                  applyCupertinoTheme: true,

                                  // activeThumbImage: ColorsManager.,
                                  onChanged: (value) {
                                    context
                                        .read<PartsCubit>()
                                        .changeAllowEdit();
                                    // setState(() {
                                    //   context
                                    //       .read<ChockCubit>()
                                    //       .changeViewPartsSwitch();
                                    // });
                                  }),
                            ],
                          )
                        : SizedBox(),
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
                            color: context.read<AppCubit>().currentThemeMode ==
                                    ThemeMode.light
                                ? ColorsManager.orangeColor
                                : ColorsManager.redAccent,
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
                      hintText: translatedText(
                        context: context,
                        arabicText: "اسم العنصر",
                        englishText: "Part Name",
                      ),
                      //  "أسم القطعة",
                      // isReadOnly: widget.isViewOnly,
                    ),
                    CustomTextFormField(
                      textFieldController: materialNumberController,
                      hintText: translatedText(
                        context: context,
                        arabicText: "رقم ماتريال",
                        englishText: "Material number",
                      ),
                      //  "رقم ماتريال",
                      keyboardType: TextInputType.number,
                      // isReadOnly: widget.isViewOnly,
                    ),
                    CustomTextFormField(
                      textFieldController: drawingPartNumberController,
                      hintText: translatedText(
                        context: context,
                        arabicText: "رقم القطعة في الرسمة",
                        englishText: "Item number in drawing",
                      ),
                      // "رقم القطعة في الرسمة",
                      keyboardType: TextInputType.number,
                      // isReadOnly: widget.isViewOnly,
                    ),
                    DropdownMenu(
                      controller: dropDownTypeController,
                      initialSelection: widget.isEdit
                          ? widget.partModel!.type
                          : translatedText(
                              context: context,
                              arabicText: "arabicText",
                              englishText: "Part",
                            ),
                      width: context.width,
                      // enabled: !widget.isViewOnly,
                      leadingIcon: Icon(Icons.settings_suggest_outlined),
                      inputDecorationTheme: InputDecorationTheme(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: context.read<AppCubit>().currentThemeMode ==
                                    ThemeMode.light
                                ? ColorsManager.orangeColor
                                : ColorsManager.redAccent,
                          ),
                        ),
                      ),
                      label: Text(
                        // 'اختر نوع القطعة',
                        translatedText(
                            context: context,
                            arabicText: "اختر نوع العنصر",
                            englishText: "Choose part type"),
                        style: MyTextStyles.lable18OrangeBold(
                            theme: Theme.of(context)),
                      ),
                      dropdownMenuEntries: [
                        menuEntry(
                          translatedText(
                            context: context,
                            arabicText: "قطعة",
                            englishText: "Part",
                          ),
                          // "Part",
                        ),
                        menuEntry(
                          translatedText(
                            context: context,
                            arabicText: "اويل سيل",
                            englishText: "Seal",
                          ),
                          // "Seal",
                        ),
                        menuEntry(
                          translatedText(
                            context: context,
                            arabicText: "بيرينج",
                            englishText: "Bearing",
                          ),
                          // "Bearing",
                        ),
                        menuEntry(
                          translatedText(
                            context: context,
                            arabicText: "كرسي",
                            englishText: "Chock",
                          ),
                        ),
                        menuEntry(
                          translatedText(
                            context: context,
                            arabicText: "دليل",
                            englishText: "Guide",
                          ),
                          // "Guide",
                        ),
                        menuEntry(
                          translatedText(
                            context: context,
                            arabicText: "رول",
                            englishText: "Roll",
                          ),
                          // "Roll",
                        ),
                        // menuEntry("Part"),
                        // menuEntry("Seal"),
                        // menuEntry("Bearing"),
                        // menuEntry("Chock"),
                        // menuEntry("Guide"),
                        // menuEntry("Roll"),

                        // DropdownMenuEntry(value: "Part", label: "Part"),
                        // DropdownMenuEntry(value: "Seal", label: "Seal"),
                        // DropdownMenuEntry(value: "Bearing", label: "Bearing"),
                        // DropdownMenuEntry(value: "Chock", label: "Chock"),
                      ],
                    ),
                    CustomDropDown(
                      dropDownController: dropDownAreaOfUsageController,
                      part: widget,
                      borderColor: context.read<AppCubit>().currentThemeMode ==
                              ThemeMode.light
                          ? ColorsManager.orangeColor
                          : ColorsManager.redAccent,
                      mainLable: TranslatedTextWidget(
                        arabicText: 'اختار منطقة الشغل',
                        englishText: "Choose working area",
                      ),
                      // mainLable: 'اختار منطقة الشغل',
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
                      hintText: translatedText(
                        context: context,
                        arabicText: "المقاسات",
                        englishText: "Sizes",
                      ),
                      //  "المقاسات",
                      // isReadOnly: widget.isViewOnly,
                    ),
                    CustomTextFormField(
                      textFieldController: usageController,
                      hintText: translatedText(
                        context: context,
                        arabicText: "الأستخدام",
                        englishText: "Usage",
                      ),
                      //  "الأستخدام",
                      // isReadOnly: widget.isViewOnly,
                    ),
                    CustomTextFormField(
                      textFieldController: partNotesController,
                      hintText: translatedText(
                        context: context,
                        arabicText: "ملاحظات",
                        englishText: "Notes",
                      ),
                      //  "ملاحظات",
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      isRequired: false,
                      // isReadOnly: widget.isViewOnly,
                    ),
                    isSaveLoading
                        ? CircularProgressIndicator.adaptive()
                        :
                        // : context.read<PartsCubit>().allowEdit
                        CustomButton(
                            buttonName: translatedText(
                              context: context,
                              arabicText: "حفظ",
                              englishText: "Save",
                            ),
                            //  'حفظ',
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
                                      message: translatedText(
                                          context: context,
                                          arabicText:
                                              "برجاء اختيار صورة العنصر",
                                          englishText:
                                              "Please choose part image"),
                                      //  "برجاء اختيار صورة",
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
                                              materialNumberController.text))) {
                                    setState(() {
                                      isSaveLoading = false;
                                    });
                                    showCustomSnackBar(
                                      context: context,
                                      message: translatedText(
                                        context: context,
                                        arabicText:
                                            "تم تسجيل هذا العنصر بنفس رقم material number من قبل",
                                        englishText:
                                            "This material number is already exist",
                                      ),
                                      // "تم تسجيل هذا العنصر بنفس رقم material number من قبل",
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
                                    message: translatedText(
                                      context: context,
                                      arabicText: "تم الحفظ بنجاح",
                                      englishText: "Saved successfully",
                                    ),
                                    //  "تم الحفظ بنجاح",
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
                          )
                    // : TextWithColorDecoration(
                    //     lable: "اضغط علي تعديل لتعديل البيانات",
                    //     textStyle:
                    //         MyTextStyles.font16Bold(Theme.of(context)),
                    //     // backColor: ColorsManager.orangeColor,
                    //   ),
                    ,
                    widget.isEdit
                        ? !isDeleteLoading
                            ? CustomButton(
                                buttonName: translatedText(
                                  context: context,
                                  arabicText: "حذف",
                                  englishText: "Delete",
                                ),
                                //  'حذف هذا العنصر',
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
                                    await context.read<PartsCubit>().deletePart(
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
                            : CircularProgressIndicator.adaptive()
                        : SizedBox(),
                  ],
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

enum PartProccessType {
  add,
  update,
  delete,
}

DropdownMenuEntry menuEntry(
  String lable,
) =>
    DropdownMenuEntry(
      value: lable,
      label: lable,
    );
// SizedBox addPaddingWhenKeyboardAppears() {
//   final viewInsets = EdgeInsets.fromViewPadding(
//     WidgetsBinding.instance!.window.viewInsets,
//     WidgetsBinding.instance!.window.devicePixelRatio,
//   );

//   final bottomOffset = viewInsets.bottom;
//   const hiddenKeyboard = 0.0; // Always 0 if keyboard is not opened
//   final isNeedPadding = bottomOffset != hiddenKeyboard;

//   return SizedBox(height: isNeedPadding ? bottomOffset : hiddenKeyboard);
// }
