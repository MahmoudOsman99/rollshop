import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rollshop/components/widgets/text_with_color_decoration.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/chock_feature/models/assembly_steps_model.dart';

class ViewAssemblyStepScreen extends StatelessWidget {
  const ViewAssemblyStepScreen({
    super.key,
    required this.step,
  });
  final AssemblyStepModel step;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            spacing: 20.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width,
                height: context.height * 0.7,
                child: PhotoView(
                  imageProvider: CachedNetworkImageProvider(
                    step.imagePath,
                  ),
                  // backgroundDecoration: BoxDecoration(
                  //   color: ColorsManager.darkColor,
                  // ),
                  enableRotation: true,
                ),
              ),
              Row(
                spacing: 20.w,
                children: [
                  TextWithColorDecoration(
                    lable: translatedText(
                      context: context,
                      arabicText: "الشرح",
                      englishText: "Description",
                    ),
                    textStyle: MyTextStyles.font16Bold(Theme.of(context)),
                  ),
                  Text(
                    step.description,
                  ),
                ],
              ),
              Row(
                spacing: 20.w,
                children: [
                  TextWithColorDecoration(
                    lable: translatedText(
                      context: context,
                      arabicText: "ملاحظات:",
                      englishText: "Notes:",
                    ),
                    textStyle: MyTextStyles.font16Bold(Theme.of(context)),
                  ),
                  Text(
                    step.notes,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
