import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rollshop/components/widgets/snack_bar.dart';
import 'package:rollshop/core/helpers/extensions.dart';

import '../../../core/theme/colors.dart';

class BuildSelectedImages extends StatefulWidget {
  int itemCount;
  List<XFile> images;
  // Size size;
  BuildSelectedImages({
    super.key,
    required this.itemCount,
    required this.images,
    // required this.size,
  });

  @override
  State<BuildSelectedImages> createState() => _BuildSelectedImagesState();
}

class _BuildSelectedImagesState extends State<BuildSelectedImages> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height / 3,
      child: DecoratedBox(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(15),
          // color: ColorsManager.orangeColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: ColorsManager.orangeColor,
            width: 2,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: GridView.builder(
            itemCount: widget.images.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.sp,
              mainAxisSpacing: 10.sp,
            ),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  SizedBox(
                    width: context.width,
                    height: context.height / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        File(widget.images[index].path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showCustomSnackBar(
                            context: context,
                            message:
                                "Image number ${(widget.images.indexOf(widget.images[index]) + 1)} is removed",
                            color: ColorsManager.mainTeal,
                          );
                          widget.images.removeAt(
                              widget.images.indexOf(widget.images[index]));
                        });
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Colors.redAccent,
                        size: 30,
                      ),
                    ),
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
