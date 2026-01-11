import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/core/helpers/images_path.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';

class MainListItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final String pathToGo;
  const MainListItem({super.key, required this.title, required this.imagePath, required this.pathToGo});

  @override
  Widget build(BuildContext context) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, pathToGo);
        },
        child: Card(
          color: ColorsManager.whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20.r,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: SizedBox(
                  width: 80.w,
                  height: 80.h,
                  child: Image.asset(ImagesPath.bdmChockImagePath),
                ),
              ),
        
              Text("كل الكراسي", style: MyTextStyles.font16Bold(Theme.of(context)),),
            ],
          ),
        ),
      );
  }
  }