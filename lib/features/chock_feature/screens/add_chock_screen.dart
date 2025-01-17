import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/components/widgets/snack_bar.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/chock_feature/view_model/chock_cubit.dart';
import 'package:rollshop/features/chock_feature/view_model/chock_state.dart';
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

  List<XFile> pickedImages = [];

  final ImagePicker _imagePicker = ImagePicker();
  bool isEmpty = false;

  // final _controller = MultiSelectController<PartsWithMaterialNumberModel>();
  // var items = [
  //   DropdownItem(
  //       label: sl<PartsCubit>().parts[0].name,
  //       value: sl<PartsCubit>().parts[0]),
  // ];

  List<PartsWithMaterialNumberModel> _selectedParts = [];
// final assemblyFormKey =
  // // @override
  // void initState() {
  //   // WidgetsBinding.instance.addPostFrameCallback(
  //   //   (timeStamp) {},
  //   // );
  //   // if (context.read<PartsCubit>().parts.isEmpty) {
  //   //   context.read<PartsCubit>().getAllParts();
  //   // }
  //   super.initState();
  // }

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
                child: Column(
                  spacing: 20,
                  children: [
                    CustomTextFormField(
                      textFieldController: chockNameController,
                      hintText: "أسم الكرسي",
                    ),
                    CustomDropDown(
                        dropDownController: chockBearingTypeController,
                        // items: context.read<ChockCubit>().bearingTyp,
                        items: [
                          ...context
                              .read<ChockCubit>()
                              .bearingTypes
                              .map((type) => menuEntry(type))
                          // menuEntry(context.read<ChockCubit>().bearingTyp[]),
                        ],
                        mainLable: "نوع حمل البلية",
                        initialSelection:
                            context.read<ChockCubit>().bearingTypes.first),
                    // CustomTextFormField(
                    //   textFieldController: textFieldController,
                    //   hintText: "نوع حمل البلية",
                    // ),
                    CustomTextFormField(
                      textFieldController: chockNotesController,
                      hintText: "ملاحظات",
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                    ),
                    // CustomTextFormField(
                    //   textFieldController: chockNotesController,
                    //   hintText: "ملاحظات",
                    //   keyboardType: TextInputType.multiline,
                    //   maxLines: 5,
                    // ),
                    Text(
                      "مكونات الكرسي",
                      style: MyTextStyles.font24Black700Weight,
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
                            });
                          },
                        ),
                      ),
                    ),

                    Text(
                      "خطوات التجميع",
                      style: MyTextStyles.font24Black700Weight,
                    ),

                    CustomButton(
                      buttonName: "اضافة خطوة تجميع",
                      onPressed: () {
                        setState(() {
                          context.read<ChockCubit>().addField();
                        });
                      },
                      color: ColorsManager.mainTeal,
                    ),
                    if (context.read<ChockCubit>().descControllers.isNotEmpty)
                      BuildFields(),

                    // SizedBox(
                    //   child: Text("data"),
                    // ),

                    // SizedBox(
                    //   width: context.width.w,
                    //   height: context.height * 0.5,
                    //   child: DecoratedBox(
                    //     decoration: BoxDecoration(
                    //       border: Border.all(
                    //         color: isEmpty
                    //             ? ColorsManager.redColor
                    //             : ColorsManager.orangeColor,
                    //         width: 2,
                    //       ),
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     child: SelectPartsList(
                    //       allParts: context.read<PartsCubit>().parts,
                    //       //  context
                    //       //     .read<PartsCubit>()
                    //       //     .parts
                    //       //     .where((part) =>
                    //       //         part.type.trim().toLowerCase() ==
                    //       //         "part".trim())
                    //       //     .toList(),
                    //       onPartsSelected: (selectedParts) {
                    //         setState(() {
                    //           _selectedParts = selectedParts;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    CustomButton(
                      buttonName: "حفظ",
                      onPressed: () {
                        // if (BuildFields().formKey.currentState!.validate()) {
                        //   debugPrint("print accessed");
                        // } else {
                        //   debugPrint("print not accessed");
                        // }
                        if (_selectedParts.isEmpty) {
                          setState(() {
                            isEmpty = true;
                          });
                          showCustomSnackBar(
                            context: context,
                            message: "يجب اختيار عنصر واحد علي الاقل",
                            color: ColorsManager.redColor,
                          );
                          return;
                        }
                      },
                      color: ColorsManager.orangeColor,
                    ),
                    // ElevatedButton(
                    //   child: const Text('Add Chock'),
                    //   onPressed: () {
                    //     debugPrint("${_selectedParts.first.name}");
                    // final selectPartsListState = context
                    //     .findAncestorStateOfType<_SelectPartsListState>();
                    // if (selectPartsListState != null) {
                    //   final allParts = context.read<PartsCubit>().parts;
                    //   _selectedParts =
                    //       selectPartsListState.getSelectedParts(allParts);
                    //   // print(
                    //   //     'Selected Parts: ${_selectedParts.map((p) => p.name).toList()}');
                    //   // Now you have the selected parts in _selectedParts
                    //   // You can use them to create and save the Chock
                    // }
                    //   },
                    // ),
                    // SizedBox(
                    //   width: context.width,
                    //   child: DecoratedBox(
                    //     decoration: BoxDecoration(
                    //       color: ColorsManager.orangeColor,
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     child: TextButton(
                    //       onPressed: () async {
                    //         try {
                    //           List<XFile>? images =
                    //               await _imagePicker.pickMultiImage();
                    //           if (images.isNotEmpty) {
                    //             setState(() {
                    //               pickedImages = images;
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
                    //         "اختار صور خطوات التجميع",
                    //         style: MyTextStyles.font16WhiteBold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // pickedImages.isNotEmpty
                    //     ? BuildSelectedImages(
                    //         itemCount: pickedImages.length,
                    //         images: pickedImages,
                    //       )
                    //     : SizedBox(),
                    // CustomTextFormField(
                    //   textFieldController: chockDescriptionController,
                    //   hintText: "شرح طريقة التجميع",
                    //   keyboardType: TextInputType.multiline,
                    //   maxLines: 10,
                    // ),
                    // CustomButton(
                    //   buttonName: 'Upload',
                    //   color: ColorsManager.orangeColor,
                    //   onPressed: () {
                    //     debugPrint(chockNameController.text);
                    //     debugPrint(chockNotesController.text);
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
