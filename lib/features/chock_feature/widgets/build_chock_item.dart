import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/chock_feature/models/chock_type_model.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';

class BuildChockItem extends StatelessWidget {
  BuildChockItem({
    super.key,
    required this.chock,
  });
  ChockTypesModel chock;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          Routes.chockDetailesScreen,
          arguments: chock,
        );
      },
      child: SizedBox(
        // width: context.width * 0.4,
        height: context.height * 0.21,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: context.read<AppCubit>().currentThemeMode == ThemeMode.dark
                ? ColorsManager.deepGrey
                : ColorsManager.lightWhite,
            //  ColorsManager.deepGrey,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.all(5.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20.w,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    spacing: 10.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        chock.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: MyTextStyles.font16Bold(
                          Theme.of(context),
                        ),
                      ),
                      Text(
                        chock.notes,
                        style: MyTextStyles.font12(Theme.of(context),
                            fontWeight: FontWeight.normal),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: context.read<AppCubit>().currentThemeMode ==
                                  ThemeMode.dark
                              ? ColorsManager.lightBlue
                              : ColorsManager.orangeColor,
                          //  ColorsManager.redAccent,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.all(7.r),
                          child: Text(
                            chock.bearingType,
                            style: MyTextStyles.font12(Theme.of(context)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: BuildImageWithErrorHandler(
                      imageType: ImageType.network,
                      path: chock.chockImagePath,
                      boxFit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
