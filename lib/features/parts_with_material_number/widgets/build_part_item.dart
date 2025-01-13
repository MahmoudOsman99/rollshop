import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/helpers/images_path.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';
import 'package:rollshop/features/parts_with_material_number/widgets/build_image.dart';

class BuildPartItem extends StatelessWidget {
  const BuildPartItem({
    super.key,
    required this.part,
    required this.allowEdit,
  });

  final PartsWithMaterialNumberModel part;
  final bool allowEdit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!allowEdit) return;
        debugPrint("Pressed");
        context.pushNamed(Routes.editPartScreen, arguments: part);
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
                  buildPartItem(text: part.name, lable: "الأسم:"),
                  buildPartItem(
                      text: part.materialNumber, lable: "رقم ماتريال:"),
                  buildPartItem(
                      text: part.drawingPartNumber, lable: "رقم الرسمة"),
                  buildPartItem(text: part.sizes, lable: "المقاسات"),
                  buildPartItem(text: part.type, lable: "النوع"),
                ],
              ),
            ),
            SizedBox(
              width: 120.w,
              height: 120.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: part.imagePath.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: part.imagePath,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            BuildImageWithErrorHandler(
                          imageType: ImageType.asset,
                          path: ImagesPath.errorImagePath,
                        ),
                      )
                    : SizedBox(
                        child: Center(
                          child: Text(
                            "No Image",
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
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildPartItem({required dynamic text, required String lable}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        lable,
        style: MyTextStyles.font12BlackeBold,
      ),
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
