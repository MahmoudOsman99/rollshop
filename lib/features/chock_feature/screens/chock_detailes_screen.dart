import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/components/widgets/text_with_color_decoration.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/helpers/images_path.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/chock_feature/cubit/chock_cubit.dart';
import 'package:rollshop/features/chock_feature/cubit/chock_state.dart';
import 'package:rollshop/features/chock_feature/models/chock_type_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';
import 'package:rollshop/features/parts_with_material_number/widgets/build_part_item.dart';

// class ChockDetailesScreen extends StatefulWidget {
//   ChockTypesModel chock;
//   ChockDetailesScreen({
//     super.key,
//     required this.chock,
//   });

//   @override
//   State<ChockDetailesScreen> createState() => _ChockDetailesScreenState();
// }

class ChockDetailesScreen extends StatelessWidget {
  // bool isViewParts = false;

  // bool isViewSteps = false;
  final ChockTypesModel chock;
  ChockDetailesScreen({required this.chock});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ChockCubit, ChockState>(
      builder: (context, state) {
        return Scaffold(
          // appBar: AppBar(
          //   leading: IconButton(
          //     icon: Icon(Icons.adaptive.arrow_back,
          //         color: ColorsManager.whiteColor
          //         //  context.read<AppCubit>().currentThemeMode == ThemeMode.dark
          //         //     ? ColorsManager.whiteColor
          //         //     : ColorsManager.deepGrey,
          //         ),
          //     onPressed: () {
          //       context.pop();
          //     },
          //     style: ButtonStyle(
          //       backgroundColor: WidgetStatePropertyAll(
          //         context.read<AppCubit>().currentThemeMode == ThemeMode.dark
          //             ? ColorsManager.lightBlue
          //             : ColorsManager.orangeColor,
          //         // ColorsManager.redAccent
          //       ),
          //       padding: WidgetStatePropertyAll(EdgeInsets.all(10.r)),

          //       // shape: WidgetStatePropertyAll(BeveledRectangleBorder(
          //       //     borderRadius: BorderRadius.circular(10.r)))
          //     ),
          //   ),
          //   // actions: [
          //   //   Padding(
          //   //     padding: EdgeInsets.all(20.r),
          //   //     child: Icon(
          //   //       Icons.arrow_back_rounded,
          //   //     ),
          //   //   ),
          //   // ],
          // ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                top: 10.r,
                start: 10.r,
                end: 10.r,
                bottom: 10.r,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15.h,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: SizedBox(
                        height: size.height * 0.5.h,
                        width: size.width.w,
                        child: BuildImageWithErrorHandler(
                          imageType: ImageType.network,
                          path: chock.chockImagePath,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0),
                      child: Text(
                        chock.name,
                        style: MyTextStyles.font24Weight700(Theme.of(context)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10.sp,
                      children: [
                        TextWithColorDecoration(
                            // lable: "ملاحظات",
                            lable: translatedText(
                              context: context,
                              arabicText: "نوع البيرينج",
                              englishText: "Bearing Type",
                            ),
                            textStyle:
                                MyTextStyles.font16Bold(Theme.of(context))),
                        Expanded(
                          child: Text(
                            chock.bearingType,
                            style: MyTextStyles.font16Bold(Theme.of(context)),
                          ),
                        ),
                      ],
                    ),
                    // TextWithColorDecoration(
                    //   // backColor: ColorsManager.mainTeal,
                    //   // lable: "نوع البيرينج: ${chock.bearingType}",

                    //   textStyle: MyTextStyles.font16Bold(Theme.of(context)),
                    // ),
                    // TextWithColorDecoration(
                    //   // backColor: ColorsManager.mainTeal,
                    //   lable: "خطوات التجميع",
                    //   textStyle: MyTextStyles.font16Bold(Theme.of(context)),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10.sp,
                      children: [
                        TextWithColorDecoration(
                            // lable: "ملاحظات",
                            lable: translatedText(
                              context: context,
                              arabicText: "ملاحظات",
                              englishText: "Notes",
                            ),
                            textStyle:
                                MyTextStyles.font16Bold(Theme.of(context))),
                        Expanded(
                          child: Text(
                            chock.notes,
                            style: MyTextStyles.font16Bold(Theme.of(context)),
                          ),
                        ),
                      ],
                    ),
                    if (chock.assemblySteps.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 20.w,
                        children: [
                          TextWithColorDecoration(
                            lable: translatedText(
                              context: context,
                              arabicText: "اظهار خطوات التجميع",
                              englishText: "Show assembly steps",
                            ),
                            // lable: "اظهار خطوات التجميع",
                            textStyle:
                                MyTextStyles.font16Bold(Theme.of(context)),
                          ),
                          // Text(
                          //   "اظهار خطوات التجميع",
                          //   style: MyTextStyles.font16Bold(Theme.of(context)),
                          // ),
                          Switch.adaptive(
                              value: context.read<ChockCubit>().isViewSteps,
                              activeColor:
                                  context.read<AppCubit>().currentThemeMode ==
                                          ThemeMode.dark
                                      ? ColorsManager.lightBlue
                                      : ColorsManager.whiteColor,
                              activeTrackColor:
                                  context.read<AppCubit>().currentThemeMode ==
                                          ThemeMode.dark
                                      ? ColorsManager.whiteColor
                                      : ColorsManager.orangeColor,
                              applyCupertinoTheme: true,

                              // activeThumbImage: ColorsManager.,
                              onChanged: (value) {
                                context
                                    .read<ChockCubit>()
                                    .changeViewStepsSwitch();
                                // setState(() {
                                //   context
                                //       .read<ChockCubit>()
                                //       .changeViewStepsSwitch();
                                // });
                              }),
                        ],
                      ),
                    if (chock.assemblySteps.isNotEmpty &&
                        context.read<ChockCubit>().isViewSteps == true)
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: context.read<AppCubit>().currentThemeMode ==
                                    ThemeMode.light
                                ? ColorsManager.orangeColor
                                : ColorsManager.whiteColor,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: 10.sp,
                            end: 10.sp,
                            top: 5.sp,
                            bottom: 5.sp,
                          ),
                          child: SizedBox(
                            height: size.height / 2,
                            child: ListView.separated(
                              itemCount: chock.assemblySteps.length,
                              physics: BouncingScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: context
                                              .read<AppCubit>()
                                              .currentThemeMode ==
                                          ThemeMode.dark
                                      ? ColorsManager.lightBlue
                                      : ColorsManager.orangeColor,
                                );
                              },
                              itemBuilder: (context, index) {
                                // debugPrint();
                                return GestureDetector(
                                  onTap: () {
                                    context.pushNamed(
                                      Routes.viewAssemblyStepScreen,
                                      arguments: chock.assemblySteps[index],
                                    );
                                  },
                                  child: Column(
                                    // spacing: 10,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 40.h,
                                      ),
                                      Row(
                                        spacing: 10.w,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  translatedText(
                                                    context: context,
                                                    arabicText:
                                                        "شرح خطوة ${index + 1}",
                                                    englishText:
                                                        "Step ${index + 1} description",
                                                  ),
                                                  style: MyTextStyles
                                                      .font14OrangeOrRedBold(
                                                          Theme.of(context)),
                                                ),
                                                Text(
                                                  chock.assemblySteps[index]
                                                      .description,
                                                  maxLines: 12,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              // width: context.width * 0.1,
                                              // height: context.height * 0.15,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                child: CachedNetworkImage(
                                                  imageUrl: chock
                                                      .assemblySteps[index]
                                                      .imagePath,
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return BuildImageWithErrorHandler(
                                                      imageType:
                                                          ImageType.asset,
                                                      path: ImagesPath
                                                          .errorImagePath,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        // "ملاحظات علي خطوة ${index + 1}",
                                        translatedText(
                                          context: context,
                                          arabicText:
                                              "ملاحظات علي خطوة ${index + 1}",
                                          englishText:
                                              "Step ${index + 1} notes",
                                        ),
                                        style:
                                            MyTextStyles.font14OrangeOrRedBold(
                                                Theme.of(context)),
                                      ),
                                      Text(
                                        chock.assemblySteps[index].notes,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 10.h,
                    ),

                    /// The chock parts section
                    if (chock.assemblySteps.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 20.w,
                        children: [
                          TextWithColorDecoration(
                            // lable: "اظهار القطع المكون منها ال Chock",
                            lable: translatedText(
                              context: context,
                              arabicText: "اظهار القطع المكون منها ال Chock",
                              englishText: "Show chock parts",
                            ),
                            textStyle:
                                MyTextStyles.font16Bold(Theme.of(context)),
                          ),
                          Switch.adaptive(
                            value: context.read<ChockCubit>().isViewParts,
                            activeColor:
                                context.read<AppCubit>().currentThemeMode ==
                                        ThemeMode.dark
                                    ? ColorsManager.lightBlue
                                    : ColorsManager.whiteColor,
                            activeTrackColor:
                                context.read<AppCubit>().currentThemeMode ==
                                        ThemeMode.dark
                                    ? ColorsManager.whiteColor
                                    : ColorsManager.orangeColor,
                            applyCupertinoTheme: true,

                            // activeThumbImage: ColorsManager.,
                            onChanged: (value) {
                              context
                                  .read<ChockCubit>()
                                  .changeViewPartsSwitch();
                              // setState(() {
                              //   context
                              //       .read<ChockCubit>()
                              //       .changeViewPartsSwitch();
                              // });
                            },
                          ),
                        ],
                      ),
                    if (chock.parts != null &&
                        chock.parts!.isNotEmpty &&
                        context.read<ChockCubit>().isViewParts == true)
                      Column(
                        spacing: 10.sp,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TextWithColorDecoration(
                          //   // backColor: ColorsManager.mainTeal,
                          //   lable: "القطع اللتي يتكون منهاالكرسي",
                          //   textStyle: MyTextStyles.font16Bold(Theme.of(context)),
                          // ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                width: 2,
                                color:
                                    context.read<AppCubit>().currentThemeMode ==
                                            ThemeMode.light
                                        ? ColorsManager.orangeColor
                                        : ColorsManager.whiteColor,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                top: 5.r,
                                bottom: 5.r,
                              ),
                              child: SizedBox(
                                width: context.width,
                                height: context.height * 0.5,
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: chock.parts!.length,
                                  itemBuilder: (context, index) =>
                                      BuildPartItem(
                                    part: chock.parts![index],
                                    allowEdit: false,
                                    viewImage: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
