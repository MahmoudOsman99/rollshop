import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 20.h,
            children: [
              Center(
                child: SizedBox(
                  width: 150.w,
                  height: 150.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75.r),
                    child: BuildImageWithErrorHandler(
                      imageType: ImageType.network,
                      path: "https://i.imgur.com/kldXnVq.jpeg",
                    ),
                  ),
                ),
              ),
              Text(
                "Mahmoud Osman",
                style: MyTextStyles.font24Weight700(Theme.of(context)),
              ),
              Text(
                "Theme",
                style: MyTextStyles.font16Bold(Theme.of(context)),
              ),
              GestureDetector(
                  onTap: () {
                    context.read<AppCubit>().changeAppTheme();
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          width: 2,
                          color: ColorsManager.orangeColor,
                        )),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: 20.r,
                        bottom: 20.r,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                  scale: animation, child: child);
                            },
                            child: Icon(
                              context.read<AppCubit>().currentThemeMode ==
                                      ThemeMode.dark
                                  ? Icons.brightness_7
                                  : Icons.brightness_2,
                              key: ValueKey<bool>(
                                context.read<AppCubit>().currentThemeMode ==
                                    ThemeMode.dark,
                              ), // Key for animation
                            ),
                          ),
                          Text(
                            context.read<AppCubit>().currentThemeMode ==
                                    ThemeMode.dark
                                ? "Light Theme"
                                : "Dark Theme",
                            style: MyTextStyles.font16Bold(Theme.of(context)),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
