import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/helpers/images_path.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/chock_feature/models/chock_type_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/features/chock_feature/widgets/select_parts_list.dart';
import 'package:rollshop/features/parts_with_material_number/widgets/build_part_item.dart';

class ChockDetailesScreen extends StatelessWidget {
  ChockTypesModel chock;
  ChockDetailesScreen({
    super.key,
    required this.chock,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(chock.name),
      //   titleTextStyle: MyTextStyles.font32WhiteBold,
      //   centerTitle: true,
      //   backgroundColor: ColorsManager.darkModeColor,
      // ),
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
            child: Column(
              spacing: 10.h,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: size.height * 0.4,
                    width: size.width,
                    child: chock.chockImagePath != null ||
                            chock.chockImagePath.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: chock.chockImagePath,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return BuildImageWithErrorHandler(
                                imageType: ImageType.asset,
                                path: ImagesPath.errorImagePath,
                              );
                            },
                          )
                        : SizedBox(),
                    // Image.asset(
                    //   chock.chockImagePath,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
                Text(
                  chock.name,
                  style: MyTextStyles.font24Black700Weight,
                ),
                Text(
                  "خطوات التجميع",
                  style: MyTextStyles.font24Black700Weight,
                ),
                if (chock.assemblySteps.isNotEmpty)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: ColorsManager.orangeColor,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        // 10.sp
                        start: 10.sp,
                        end: 10.sp,
                        top: 5.sp,
                        bottom: 5.sp,
                      ),
                      child: SizedBox(
                        height: size.height / 2,
                        child: ListView.builder(
                          itemCount: chock.assemblySteps.length,
                          itemBuilder: (context, index) {
                            // debugPrint();
                            return Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 40.h,
                                ),
                                // Text(
                                //   chock.assemblySteps[index].description,
                                //   style: MyTextStyles.font16BlackeWeight500,
                                // ),
                                Row(
                                  spacing: 10.w,
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "شرح خطوة ${index + 1}",
                                            style:
                                                MyTextStyles.font13OrangeBold,
                                          ),
                                          Text(
                                            chock.assemblySteps[index]
                                                .description,
                                            maxLines: 12,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          // Text(
                                          //   "الشرح:  ${chock.assemblySteps[index].description}",
                                          //   maxLines: 4,
                                          //   overflow: TextOverflow.ellipsis,
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        // width: context.width * 0.1,
                                        // height: context.height * 0.15,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: chock
                                                .assemblySteps[index].imagePath,
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, error) {
                                              return BuildImageWithErrorHandler(
                                                imageType: ImageType.asset,
                                                path: ImagesPath.errorImagePath,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Text(
                                  "ملاحظات علي خطوة ${index + 1}",
                                  style: MyTextStyles.font13OrangeBold,
                                ),
                                Text(
                                  chock.assemblySteps[index].notes,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                // SizedBox(
                                //   height: size.height / 3,
                                //   width: size.width,
                                //   child: ListView.separated(
                                //     separatorBuilder: (context, index) {
                                //       return SizedBox(
                                //         width: 10,
                                //         height: 20,
                                //       );
                                //     },
                                //     scrollDirection: Axis.vertical,
                                //     itemCount: chock
                                //         .assemblySteps[index].imagesPath.length,
                                //     itemBuilder: (context, indexImage) => ClipRRect(
                                //       borderRadius: BorderRadius.circular(15),
                                //       child: InteractiveViewer(
                                //         minScale: 1.0,
                                //         maxScale: 4.0,
                                //         child: CachedNetworkImage(
                                //           imageUrl: chock.assemblySteps[index]
                                //               .imagesPath[indexImage],
                                //           errorWidget: (context, url, error) {
                                //             return BuildImageWithErrorHandler(
                                //               imageType: ImageType.asset,
                                //               path: ImagesPath.errorImagePath,
                                //             );
                                //           },
                                //         ),
                                //         // child: Image.asset(
                                //         //   chock.assemblySteps[index]
                                //         //       .imagesPath[indexImage],
                                //         //   fit: BoxFit.cover,
                                //         // ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  )
                // else
                //   SizedBox(),
                ,
                SizedBox(
                  height: 10.h,
                ),

                /// The chock parts section
                if (chock.parts != null && chock.parts!.isNotEmpty)
                  Column(
                    spacing: 10.sp,
                    children: [
                      Text(
                        "القطع اللتي يتكون منهاالكرسي",
                        style: MyTextStyles.lable18OrangeBold,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: ColorsManager.orangeColor,
                          ),
                        ),
                        child: SizedBox(
                          width: context.width,
                          height: context.height * 0.4,
                          child: ListView.builder(
                            itemCount: chock.parts!.length,
                            itemBuilder: (context, index) => BuildPartItem(
                                part: chock.parts![index], allowEdit: false),
                          ),
                        ),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.sp,
                  children: [
                    Text(
                      "ملاحظات:",
                      style: MyTextStyles.font32OrangeBold,
                    ),
                    Expanded(
                      child: Text(
                        chock.notes,
                        style: MyTextStyles.font16BlackeBold,
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
  }
}
