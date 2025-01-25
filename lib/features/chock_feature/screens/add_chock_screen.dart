import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/components/widgets/snack_bar.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/chock_feature/cubit/chock_cubit.dart';
import 'package:rollshop/features/chock_feature/cubit/chock_state.dart';
import 'package:rollshop/features/chock_feature/widgets/build_fields.dart';
import 'package:rollshop/features/chock_feature/widgets/select_parts_list.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';
import 'package:rollshop/features/parts_with_material_number/screens/add_parts_with_material_number_screen.dart';
import 'package:rollshop/features/parts_with_material_number/view_model/cubit/parts_cubit.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChockCubit, ChockState>(
      bloc: context.read<ChockCubit>(),
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
                                color: ColorsManager.orangeColor,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.all(5.sp),
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
                                          "رفع صورة الكرسي",
                                          style: MyTextStyles.font32OrangeBold,
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        textFieldController: chockNameController,
                        hintText: "أسم الكرسي",
                      ),
                      CustomDropDown(
                        dropDownController: chockBearingTypeController,
                        items: [
                          ...context
                              .read<ChockCubit>()
                              .bearingTypes
                              .map((type) => menuEntry(type))
                        ],
                        mainLable: "نوع حمل البلية",
                        initialSelection:
                            context.read<ChockCubit>().bearingTypes.first,
                      ),
                      CustomTextFormField(
                        textFieldController: chockHowToCalcShimController,
                        hintText: "طريقة قياس الشيمز",
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                      ),
                      CustomTextFormField(
                        textFieldController: chockNotesController,
                        hintText: "ملاحظات",
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                      ),
                      Text(
                        "مكونات الكرسي",
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
                                  : ColorsManager.orangeColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
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
                        "خطوات التجميع",
                        style: MyTextStyles.font24Weight700(Theme.of(context)),
                      ),
                      CustomButton(
                        buttonName: "اضافة خطوة تجميع",
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
                        color: ColorsManager.mainTeal,
                      ),
                      if (context.read<ChockCubit>().descControllers.isNotEmpty)
                        BuildFields(),
                      CustomButton(
                        buttonName: "حفظ",
                        onPressed: () {
                          // debugPrint(chockBearingTypeController.text);

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
                        color: ColorsManager.orangeColor,
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
