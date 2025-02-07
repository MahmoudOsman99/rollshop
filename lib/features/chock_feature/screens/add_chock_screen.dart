import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rollshop/components/widgets/custom_app_bar.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/components/widgets/custom_drop_down_menu.dart';
import 'package:rollshop/components/widgets/snack_bar.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/chock_feature/cubit/chock_cubit.dart';
import 'package:rollshop/features/chock_feature/cubit/chock_state.dart';
import 'package:rollshop/features/chock_feature/widgets/build_fields.dart';
import 'package:rollshop/features/chock_feature/widgets/select_parts_list.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';
import 'package:rollshop/features/parts_with_material_number/cubit/parts_cubit.dart';

import '../../../components/widgets/custom_text_field.dart';

class AddChockScreen extends StatefulWidget {
  const AddChockScreen({super.key});

  @override
  State<AddChockScreen> createState() => _AddChockScreenState();
}

class _AddChockScreenState extends State<AddChockScreen> {
  TextEditingController chockNameController = TextEditingController();
  TextEditingController chockDescriptionController = TextEditingController();
  TextEditingController chockBearingTypeController = TextEditingController();
  TextEditingController chockNotesController = TextEditingController();
  TextEditingController chockHowToCalcShimController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<XFile> pickedImages = [];

  final ImagePicker _chockImagePicker = ImagePicker();
  File? chockImagePath;
  bool isEmpty = false;

  List<PartsWithMaterialNumberModel> _selectedParts = [];
  @override
  void initState() {
    if (context.read<ChockCubit>().descControllers.isEmpty) {
      context.read<ChockCubit>().addField();
    }
    // if (context.read<ChockCubit>().bearingTypes.isEmpty) {
    //   context.read<ChockCubit>().getBearingTypes();
    //   debugPrint(context.read<ChockCubit>().bearingTypes.first);
    // }
    super.initState();
  }

  @override
  void dispose() {
    // context.read<ChockCubit>().descControllers.clear();
    // context.read<ChockCubit>().notesControllers.clear();
    // context.read<ChockCubit>().imagesPathes.clear();
    super.dispose();
    // context.read<ChockCubit>().clearFields();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChockCubit, ChockState>(
      bloc: context.read<ChockCubit>(),
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: FittedBox(
              child: TranslatedTextWidget(
                arabicText: "اضافة عنصر جديد",
                englishText: "Add New Item",
                textStyle: MyTextStyles.font24Weight700(Theme.of(context)),
              ),
            ),
            isCenteredTitle: true,
            textStyle: MyTextStyles.font24Weight700(Theme.of(context)),
            backColor: ColorsManager.lightBlue,
          ),
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: 50.sp,
                left: 10.sp,
                right: 10.sp,
                bottom: 30.sp,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    spacing: 20,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          XFile? selectedChockImage = await _chockImagePicker
                              .pickImage(source: ImageSource.gallery);
                          if (selectedChockImage != null) {
                            setState(() {
                              chockImagePath = File(selectedChockImage.path);
                            });
                          }
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color:
                                  context.read<AppCubit>().currentThemeMode ==
                                          ThemeMode.dark
                                      ? ColorsManager.whiteColor
                                      : ColorsManager.orangeColor,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5.r),
                            child: SizedBox(
                              height: context.height * 0.3,
                              width: context.width * 0.7,
                              child: chockImagePath != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        chockImagePath!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.upload,
                                          size: 100,
                                          color: ColorsManager.orangeColor,
                                        ),
                                        Text(
                                          // "رفع صورة الكرسي",
                                          translatedText(
                                            context: context,
                                            arabicText: "تحميل صورة الكرسي",
                                            englishText: "Upload chock image",
                                          ),
                                          style: MyTextStyles.font24Weight700(
                                              Theme.of(context)),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        textFieldController: chockNameController,
                        hintText: translatedText(
                          context: context,
                          arabicText: "اسم الكرسي",
                          englishText: "Chock name",
                        ),
                        // hintText: "أسم الكرسي",
                      ),
                      CustomDropDown(
                        dropDownController: chockBearingTypeController,
                        borderColor: ColorsManager.lightBlue,
                        items: [
                          // ...context
                          //     .read<ChockCubit>()
                          //     .getBearingTypes().then((types)=>{
                          // ...types
                          //     })
                          // .map((type) => menuEntry(type))
                          ...context
                              .read<ChockCubit>()
                              .bearingTypes
                              .map((type) => menuEntry(type))
                        ],
                        mainLable: TranslatedTextWidget(
                          arabicText: "نوع حمل البلية",
                          englishText: "Bearing Type",
                        ),
                        // mainLable: "نوع حمل البلية",
                        initialSelection:
                            context.read<ChockCubit>().bearingTypes.isNotEmpty
                                ? context.read<ChockCubit>().bearingTypes.first
                                : "",
                      ),
                      CustomTextFormField(
                        textFieldController: chockHowToCalcShimController,
                        hintText: translatedText(
                          context: context,
                          arabicText: "طريقة قياس الشيمز",
                          englishText: "How to calculate bearing shim",
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                      ),
                      CustomTextFormField(
                        textFieldController: chockNotesController,
                        hintText: translatedText(
                          context: context,
                          arabicText: "ملاحظات",
                          englishText: "Notes",
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                      ),
                      Text(
                        translatedText(
                          context: context,
                          arabicText: "مكونات الكرسي",
                          englishText: "Chock's Parts",
                        ),
                        style: MyTextStyles.font24Weight700(Theme.of(context)),
                      ),
                      SizedBox(
                        width: context.width.w,
                        height: context.height * 0.5,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isEmpty
                                  ? ColorsManager.redColor
                                  : context.read<AppCubit>().currentThemeMode ==
                                          ThemeMode.dark
                                      ? ColorsManager.whiteColor
                                      : ColorsManager.orangeColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: SelectPartsList(
                            allParts: context.read<PartsCubit>().parts,
                            //  context
                            //     .read<PartsCubit>()
                            //     .parts
                            //     .where((part) =>
                            //         part.type.trim().toLowerCase() ==
                            //         "part".trim())
                            //     .toList(),
                            onPartsSelected: (selectedParts) {
                              setState(() {
                                _selectedParts = selectedParts;
                                context.read<ChockCubit>().selectedParts =
                                    selectedParts;
                                debugPrint(context
                                    .read<ChockCubit>()
                                    .selectedParts
                                    .length
                                    .toString());
                              });
                            },
                          ),
                        ),
                      ),
                      Text(
                        // "خطوات التجميع",
                        translatedText(
                            context: context,
                            arabicText: "خطوات التجميع",
                            englishText: "Assembly steps"),
                        style: MyTextStyles.font24Weight700(Theme.of(context)),
                      ),
                      CustomButton(
                        buttonName: translatedText(
                            context: context,
                            arabicText: "اضافة خطوة تجميع",
                            englishText: "Add assembly step"),
                        //  "اضافة خطوة تجميع",
                        onPressed: () {
                          if (context.read<ChockCubit>().imagesPathes.length <
                              context
                                  .read<ChockCubit>()
                                  .descControllers
                                  .length) {
                            //  debugPrint("print not accessed");
                            showCustomSnackBar(
                              context: context,
                              color: ColorsManager.redColor,
                              message:
                                  "يجب اختيار صورة خطوة التجميع رقم ${context.read<ChockCubit>().descControllers.length}",
                            );
                            return;
                          }
                          setState(() {
                            context.read<ChockCubit>().addField();
                          });
                        },
                        color: ColorsManager.lightBlue,
                      ),
                      if (context.read<ChockCubit>().descControllers.isNotEmpty)
                        BuildFields(),
                      CustomButton(
                        buttonName: translatedText(
                          context: context,
                          arabicText: "حفظ",
                          englishText: "Save",
                        ),
                        onPressed: () {
                          // debugPrint(chockBearingTypeController.text);
                          if (chockImagePath == null) {
                            showCustomSnackBar(
                              context: context,
                              message: "يجب اختيار اختيار صورة للكرسي",
                              color: ColorsManager.redColor,
                            );
                            return;
                          }

                          if (_selectedParts.isEmpty) {
                            setState(() {
                              isEmpty = true;
                            });
                            showCustomSnackBar(
                              context: context,
                              message:
                                  "يجب اختيار عنصر واحد علي الاقل من مكونات الكرسي",
                              color: ColorsManager.redColor,
                            );
                            return;
                          } else if (context
                                  .read<ChockCubit>()
                                  .descControllers
                                  .isEmpty ||
                              (context
                                      .read<ChockCubit>()
                                      .descControllers
                                      .isNotEmpty &&
                                  context
                                      .read<ChockCubit>()
                                      .descControllers
                                      .first
                                      .text
                                      .isEmpty)) {
                            showCustomSnackBar(
                              context: context,
                              message: "يجب ادخال خطوات التجميع",
                              color: ColorsManager.redColor,
                            );
                            return;
                          } else {
                            if (formKey.currentState!.validate()) {
                              showCustomSnackBar(
                                context: context,
                                message: "برجاء الانتظار حتي يتم حفظ البيانات",
                                color: ColorsManager.mainTeal,
                              );
                              context.read<ChockCubit>().saveChockDetailes(
                                    name: chockNameController.text,
                                    bearingType:
                                        chockBearingTypeController.text,
                                    chockImagePath: chockImagePath!,
                                    notes: chockNotesController.text,
                                    howTocalcBearingShim:
                                        chockHowToCalcShimController.text,
                                  );
                              showCustomSnackBar(
                                context: context,
                                message: "تم الحفظ بنجاح",
                                color: ColorsManager.mainTeal,
                              );
                              // context.read<ChockCubit>().clearFields();
                              context.pop();
                            } else {
                              showCustomSnackBar(
                                context: context,
                                message: "كمل بيانات الكرسي",
                                color: ColorsManager.redColor,
                              );
                            }
                          }
                        },
                        color: ColorsManager.lightBlue,
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
}

DropdownMenuEntry menuEntry(
  String lable,
) =>
    DropdownMenuEntry(
      value: lable,
      label: lable,
    );
