import 'package:flutter/material.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/components/widgets/text_with_color_decoration.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';

class PartDetailesScreen extends StatelessWidget {
  final PartsWithMaterialNumberModel part;
  const PartDetailesScreen({
    super.key,
    required this.part,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(part.name)),
        titleTextStyle: MyTextStyles.font32Bold(Theme.of(context)),
        centerTitle: true,
        // backgroundColor: ColorsManager.darkModeColor,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // context.read<ChockCubit>().addOneChock(newChock: null);
      //     context.pushNamed(Routes.addChockScreen);
      //   },
      //   backgroundColor: ColorsManager.orangeColor,
      //   child: Icon(
      //     Icons.add,
      //     color: ColorsManager.whiteColor,
      //     size: 50,
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              spacing: 20.h,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: SizedBox(
                    height: context.height / 2,
                    width: context.width,
                    child: BuildImageWithErrorHandler(
                      imageType: ImageType.network,
                      path: part.imagePath,
                    ),
                  ),
                ),
                // BuildPartItem(
                //   part: part,
                //   allowEdit: false,
                //   viewImage: false,
                // ),
                BuildPartDetailes(
                  text: part.materialNumber.toString(),
                  lable: translatedText(
                    context: context,
                    arabicText: "رقم ماتريال",
                    englishText: "Material Number",
                  ),
                ),
                BuildPartDetailes(
                  text: part.drawingPartNumber.toString(),
                  lable: translatedText(
                    context: context,
                    arabicText: "رقم الرسمة",
                    englishText: "Drawing Number",
                  ),
                ),
                BuildPartDetailes(
                  text: part.usage,
                  lable: translatedText(
                    context: context,
                    arabicText: "الأستخدام",
                    englishText: "Usage",
                  ),
                ),
                BuildPartDetailes(
                  text: part.sizes,
                  lable: translatedText(
                    context: context,
                    arabicText: "المقاسات",
                    englishText: "Sizes",
                  ),
                ),
                BuildPartDetailes(
                  text: part.type,
                  lable: translatedText(
                    context: context,
                    arabicText: "النوع",
                    englishText: "Type",
                  ),
                ),
                BuildPartDetailes(
                  text: part.notes ??
                      translatedText(
                        context: context,
                        arabicText: "لا توجد ملاحظات",
                        englishText: "No notes founded",
                      ),
                  lable: translatedText(
                    context: context,
                    arabicText: "ملاحظات",
                    englishText: "Notes",
                  ),
                ),

                // buildPartItem(
                //   text: translatedText(
                //     context: context,
                //     arabicText: "الأسم",
                //     englishText: "Name",
                //   ),
                //   lable: Text(part.name),
                //   context: context,
                // ),
                // TranslatedTextWidget(
                //   arabicText: "",
                //   englishText: "",
                // ),
                // Text(
                //   "خطوات التجميع",
                //   style: MyTextStyles.font24Weight700(Theme.of(context)),
                // ),
                // if (chock.assemblySteps.isNotEmpty)
                // SizedBox(
                //   height: context.height / 2,
                //   child: ListView.builder(
                //     itemCount: chock.assemblySteps.length,
                //     itemBuilder: (context, index) {
                //       return Column(
                //         children: [
                //           Text(
                //             chock.assemblySteps[index].description,
                //             style: MyTextStyles.font16BlackeWeight500,
                //           ),
                //           SizedBox(
                //             height: 10,
                //           ),
                //           // SizedBox(
                //           //   height: context.height / 3,
                //           //   width: context.width,
                //           //   child: ListView.separated(
                //           //     separatorBuilder: (context, index) {
                //           //       return SizedBox(
                //           //         width: 10,
                //           //         height: 20,
                //           //       );
                //           //     },
                //           //     scrollDirection: Axis.vertical,
                //           //     itemCount: chock
                //           //         .assemblySteps[index].imagesPath.length,
                //           //     itemBuilder: (context, indexImage) => ClipRRect(
                //           //       borderRadius: BorderRadius.circular(15),
                //           //       child: InteractiveViewer(
                //           //         minScale: 1.0,
                //           //         maxScale: 4.0,
                //           //         child: Image.asset(
                //           //           chock.assemblySteps[index]
                //           //               .imagesPath[indexImage],
                //           //           fit: BoxFit.cover,
                //           //         ),
                //           //       ),
                //           //     ),
                //           //   ),
                //           // ),
                //         ],
                //       );
                //     },
                //   ),
                // ),
                // BuildPartItem(
                //   part: part,
                //   allowEdit: false,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   spacing: 10.sp,
                //   children: [
                //     Text(
                //       part.notes!,
                //       style: MyTextStyles.font32OrangeBold,
                //     ),
                //     Text(
                //       ":ملاحظات",
                //       style: MyTextStyles.font32OrangeBold,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildPartDetailes extends StatelessWidget {
  const BuildPartDetailes({
    super.key,
    // required this.part,
    required this.text,
    required this.lable,
  });

  // final PartsWithMaterialNumberModel part;
  final String text;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20.w,
      children: [
        TextWithColorDecoration(
          lable: lable,
          textStyle: MyTextStyles.font16Bold(Theme.of(context)),
        ),
        // Spacer(),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
                // color: Colors.amber,
                ),
            child: Text(
              text,
              textDirection: TextDirection.ltr,
              style: MyTextStyles.font16Bold(Theme.of(context)),
              // maxLines: 6,
              // overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
