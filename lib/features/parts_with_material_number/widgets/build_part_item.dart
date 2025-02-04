import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/components/widgets/snack_bar.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/helpers/images_path.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';

class BuildPartItem extends StatelessWidget {
  const BuildPartItem({
    super.key,
    required this.part,
    required this.allowEdit,
    this.viewImage = true,
  });

  final PartsWithMaterialNumberModel part;
  final bool allowEdit;
  final bool viewImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!allowEdit) return;
        // debugPrint("Pressed");
        // context.pushNamed(Routes.editPartScreen, arguments: part);
        context.pushNamed(Routes.partDetailesScreen, arguments: part);
      },
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildPartItem(
                    text: part.name,
                    lable: TranslatedTextWidget(
                      arabicText: "الأسم:",
                      englishText: "Name:",
                    ),
                    context: context,
                  ),
                  buildPartItem(
                    text: part.materialNumber,
                    lable: TranslatedTextWidget(
                      arabicText: "رقم ماتريال:",
                      englishText: "Material Number:",
                    ),
                    context: context,
                  ),
                  buildPartItem(
                    text: part.drawingPartNumber,
                    lable: TranslatedTextWidget(
                      arabicText: "رقم الرسمة:",
                      englishText: "Drawing Number:",
                    ),
                    context: context,
                  ),
                  buildPartItem(
                    text: part.sizes,
                    lable: TranslatedTextWidget(
                      arabicText: "المقاسات:",
                      englishText: "Size:",
                    ),
                    context: context,
                  ),
                  buildPartItem(
                    text: part.type,
                    lable: TranslatedTextWidget(
                      arabicText: "النوع:",
                      englishText: "Type:",
                    ),
                    context: context,
                  ),
                ],
              ),
            ),
            viewImage
                ? SizedBox(
                    width: 120.w,
                    height: 120.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: part.imagePath.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: part.imagePath,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator.adaptive()),
                              errorWidget: (context, url, error) =>
                                  BuildImageWithErrorHandler(
                                imageType: ImageType.asset,
                                path: ImagesPath.errorImagePath,
                              ),
                            )
                          : SizedBox(
                              child: Center(
                                child: Text(
                                  // "No Image",
                                  translatedText(
                                      context: context,
                                      arabicText: "لا توجد صورة",
                                      englishText: "No Image"),
                                ),
                              ),
                            ),
                      // ? BuildImageWithErrorHandler(
                      //     imageType: ImageType.network,
                      //     // path: parts[index].imagePath,
                      //     path: part.imagePath,
                      //     boxFit: BoxFit.cover,
                      //   )
                      // : SizedBox(
                      //     child: Center(
                      //       child: Text(
                      //         "No Image",
                      //       ),
                      //     ),
                      //   ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

Widget buildPartItem({
  required dynamic text,
  // required String lable,
  required Widget lable,
  required BuildContext context,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      lable,
      Flexible(
        child: Text(
          text.toString(),
          textDirection: TextDirection.ltr,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    ],
  );
}
