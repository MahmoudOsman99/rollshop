import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/theme/colors.dart';

class BuildImage extends StatelessWidget {
  const BuildImage({
    super.key,
    required this.image,
  });
  final XFile image;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border.all(
        width: 2,
        color: ColorsManager.orangeColor,
      )),
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            width: context.width * 0.7,
            height: context.height / 3,
            child: Image.file(
              File(image.path),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
