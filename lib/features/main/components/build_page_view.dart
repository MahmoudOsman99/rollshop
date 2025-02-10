import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/theme/styles.dart';

class BuildPageView extends StatelessWidget {
  const BuildPageView({
    super.key,
    required this.color,
    required this.text,
    required this.subText,
    this.imagePath,
    this.isSVG = false,
  });
  final Color color;
  final String text;
  final String subText;
  final String? imagePath;
  final bool isSVG;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: context.height / 2,
          width: context.width,
          child: isSVG
              ? SvgPicture.asset(imagePath!)
              : BuildImageWithErrorHandler(
                  imageType: ImageType.asset,
                  path: imagePath ?? "assets/images/list.jpg",
                ),
        ),
        Padding(
          padding: EdgeInsets.all(20.r),
          child: Text(
            text,
            style: MyTextStyles.font32OrangeBold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Text(
            subText,
            style: MyTextStyles.font16Bold(Theme.of(context)),
          ),
        ),
      ],
    );
  }
}
