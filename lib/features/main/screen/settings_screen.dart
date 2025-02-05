import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/components/widgets/custom_drop_down_menu.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              TranslatedTextWidget(
                arabicText: "محمود عثمان",
                englishText: "Mahmoud Osman",
                textStyle: MyTextStyles.font24Weight700(Theme.of(context)),
              ),
              // Text(
              //   "Mahmoud Osman",
              //   style: MyTextStyles.font24Weight700(Theme.of(context)),
              // ),
              // Text(
              //   "Theme",
              //   style: MyTextStyles.font16Bold(Theme.of(context)),
              // ),
              GestureDetector(
                onTap: () {
                  context.read<AppCubit>().changeAppTheme();
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        width: 2,
                        color: context.read<AppCubit>().currentThemeMode ==
                                ThemeMode.dark
                            ? ColorsManager.lightBlue
                            : ColorsManager.orangeColor,
                      )),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: 20.r,
                      bottom: 20.r,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // spacing: 20.w,
                        children: [
                          Icon(
                            context.read<AppCubit>().currentThemeMode ==
                                    ThemeMode.dark
                                ? Icons.brightness_7
                                : Icons.brightness_2,
                            key: ValueKey<bool>(
                              context.read<AppCubit>().currentThemeMode ==
                                  ThemeMode.dark,
                            ), // Key for animation
                          ),
                          Text(
                            context.read<AppCubit>().currentThemeMode ==
                                    ThemeMode.dark
                                ? translatedText(
                                    context: context,
                                    arabicText: "الوضع الفاتح",
                                    englishText: "Light Theme",
                                  )
                                : translatedText(
                                    context: context,
                                    arabicText: "الوضع الليلي",
                                    englishText: "Dark Theme",
                                  ),
                            style: MyTextStyles.font16Bold(Theme.of(context)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              CustomDropDown(
                items: [
                  DropdownMenuEntry(value: 'en', label: "English"),
                  DropdownMenuEntry(value: 'ar', label: "اللغة العربية"),
                ],
                onSelected: (value) {
                  if (value != null) {
                    context.read<AppCubit>().changeAppLocale(value);
                  }
                },
                borderColor:
                    context.read<AppCubit>().currentThemeMode == ThemeMode.dark
                        ? ColorsManager.lightBlue
                        : ColorsManager.orangeColor,
                icon: Icon(Icons.language),
                mainLable: TranslatedTextWidget(
                  arabicText: "لغة التطبيق",
                  englishText: "App language",
                  textStyle:
                      MyTextStyles.lable18OrangeBold(theme: Theme.of(context)),
                ),
                initialSelection:
                    context.read<AppCubit>().currentLocale.languageCode,
              ),

              CustomButton(
                buttonName: translatedText(
                  context: context,
                  arabicText: "دخول",
                  englishText: "Sign in",
                ),
                onPressed: () {
                  context.pushNamed(Routes.loginScreen);
                },
                color:
                    context.read<AppCubit>().currentThemeMode == ThemeMode.dark
                        ? ColorsManager.lightBlue
                        : ColorsManager.orangeColor,
              ),
              // CustomDropDown(items: [], mainLable: mainLable, initialSelection: initialSelection)
              // GestureDetector(
              //   onTap: () {
              //     context.read<AppCubit>().changeAppLocale("ar");
              //   },
              //   child: DecoratedBox(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10.r),
              //         border: Border.all(
              //           width: 2,
              //           color: context.read<AppCubit>().currentThemeMode ==
              //                   ThemeMode.dark
              //               ? ColorsManager.redAccent
              //               : ColorsManager.orangeColor,
              //         )),
              //     child: Padding(
              //       padding: EdgeInsetsDirectional.only(
              //         top: 20.r,
              //         bottom: 20.r,
              //       ),
              //       child: AnimatedSwitcher(
              //         duration: const Duration(milliseconds: 500),
              //         transitionBuilder:
              //             (Widget child, Animation<double> animation) {
              //           return ScaleTransition(
              //             scale: animation,
              //             child: child,
              //           );
              //         },
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           // spacing: 20.w,
              //           children: [
              //             Icon(
              //               // context.read<AppCubit>().currentThemeMode ==
              //               //         ThemeMode.dark
              //                   // ?
              //                    Icons.language,
              //                   // : Icons.brightness_2,
              //               key: ValueKey<bool>(
              //                 context.read<AppCubit>().currentThemeMode ==
              //                     ThemeMode.dark,
              //               ), // Key for animation
              //             ),
              //             Text(
              //               context.read<AppCubit>().currentLocale ==
              //                       Locale('ar')
              //                   ? "اللغة العربية"
              //                   : "English",
              //               style: MyTextStyles.font16Bold(Theme.of(context)),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
