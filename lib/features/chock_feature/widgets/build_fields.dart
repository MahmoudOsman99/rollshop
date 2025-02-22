import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/components/widgets/custom_text_field.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/chock_feature/cubit/chock_cubit.dart';

class BuildFields extends StatefulWidget {
  const BuildFields({super.key});

  @override
  State<BuildFields> createState() => _BuildFieldsState();
}

class _BuildFieldsState extends State<BuildFields> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 2,
          color: ColorsManager.lightBlue,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: SizedBox(
          width: context.width,
          height: context.height * 0.6,
          child: ListView.separated(
            itemCount: context.read<ChockCubit>().descControllers.length,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 40.h,
                child: Divider(
                  color: ColorsManager.orangeColor,
                  height: 3,
                ),
              );
            },
            itemBuilder: (context, index) {
              return Column(
                spacing: 20.h,
                children: [
                  GestureDetector(
                    onTap: () async {
                      // if (context.read<ChockCubit>().imagesPathes.isNotEmpty) {
                      //   // if(context.read<ChockCubit>().imagesPathes[index])
                      //   if (context.read<ChockCubit>().descControllers.length ==
                      //       context.read<ChockCubit>().imagesPathes.length) {
                      //     context.read<ChockCubit>().removeImage(index);
                      //   }
                      // }
                      XFile? selectedImage;

                      selectedImage = await context
                          .read<ChockCubit>()
                          .pickers[index]
                          .pickImage(source: ImageSource.gallery);
                      // if (context.read<ChockCubit>().imagesPathes.isNotEmpty &&
                      //     selectedImage != null) {
                      //   debugPrint("Not empty ========================");
                      //   // context.read<ChockCubit>().imagesPathes.remove(
                      //   //     context.read<ChockCubit>().imagesPathes[index]);
                      // }
                      if (selectedImage != null) {
                        // &&
                        //   context.read<ChockCubit>().imagesPathes.length !=
                        //       context.read<ChockCubit>().pickers.length
                        // context.read<ChockCubit>()
                        setState(() {
                          context
                              .read<ChockCubit>()
                              .addImage(File(selectedImage!.path), index);
                        });
                        // debugPrint(
                        //     "${context.read<ChockCubit>().imagesPathes.length}");
                        // context
                        //     .read<ChockCubit>()
                        //     .imagesPathes
                        //     .add(File(selectedImage.path));
                      }
                      // debugPrint(
                      //     "${context.read<ChockCubit>().descControllers.length}");
                    },
                    child: SizedBox(
                      width: 150.w,
                      height: 150.h,
                      child: context
                                  .read<ChockCubit>()
                                  .imagesPathes
                                  .isNotEmpty &&
                              context.read<ChockCubit>().imagesPathes.length >
                                  index
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: BuildImageWithErrorHandler(
                                imageType: ImageType.file,
                                path: context
                                    .read<ChockCubit>()
                                    .imagesPathes[index],
                                boxFit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.upload,
                              size: 50,
                              color: ColorsManager.orangeColor,
                            ),
                    ),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    spacing: 20,
                    children: [
                      TranslatedTextWidget(
                        arabicText: "خطوة رقم ${index + 1}",
                        englishText: "Step number: ${index + 1}",
                        textStyle: MyTextStyles.font16Bold(Theme.of(context)),
                      ),
                      // textAlign: TextAlign.right,
                      index > 0
                          ? DecoratedBox(
                              decoration: BoxDecoration(
                                color: ColorsManager.redColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  setState(() {
                                    context
                                        .read<ChockCubit>()
                                        .removeField(index);
                                  });

                                  // final result = await showDialog<bool>(
                                  //   context: context,
                                  //   builder: (context) {
                                  //     return AlertDialog(
                                  //       title: const Text('تأكيد الحذف'),
                                  //       content: Text('هل تريد حذف هذا العنصر?'),
                                  //       actions: <Widget>[
                                  //         TextButton(
                                  //           onPressed: () => context
                                  //               .pop(), // Return false//////////////////////////
                                  //           child: const Text('الغاء'),
                                  //         ),
                                  //         TextButton(
                                  //           onPressed: () => Navigator.of(context)
                                  //               .pop(true), // Return true
                                  //           child: const Text(
                                  //             'تأكيد',
                                  //             style: TextStyle(
                                  //               color: ColorsManager.redColor,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     );
                                  //   },
                                  // );
                                  // if (result == true) {
                                  //   context.read<ChockCubit>().removeField(index);

                                  //   showCustomSnackBar(
                                  //     context: context,
                                  //     message: "تم حذف العنصر بنجاح",
                                  //     color: ColorsManager.redColor,
                                  //   );
                                  // } else {
                                  //   showCustomSnackBar(
                                  //     context: context,
                                  //     message: "لم يتم الحذف",
                                  //     color: ColorsManager.mainTeal,
                                  //   );
                                  // }
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 30,
                                  color: ColorsManager.whiteColor,
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  CustomTextFormField(
                    textFieldController:
                        context.read<ChockCubit>().descControllers[index],
                    // hintText:
                    hintText: translatedText(
                        context: context,
                        arabicText: "شرح",
                        englishText: "Description"),
                    // "شرح ${context.read<ChockCubit>().descControllers.length}",
                    // "شرح",
                    maxLines: 3,
                  ),
                  CustomTextFormField(
                    textFieldController:
                        context.read<ChockCubit>().notesControllers[index],
                    maxLines: 2,
                    hintText: translatedText(
                        context: context,
                        arabicText: "ملاحظات",
                        englishText: "Notes"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
