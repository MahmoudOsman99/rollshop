import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/main/components/build_page_view.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();

  bool isLastIndex = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: isLastIndex
          ? SizedBox(
              height: 80,
              width: context.width,
              child: CustomButton(
                raduis: 0,
                buttonName: "Get Started",
                onPressed: () async {
                  // await SharedPreferencesHelper.setBoolValue(
                  //   "onBoarding",
                  //   true,
                  // );
                  context.pushReplacementNamed(Routes.registerScreen);
                },
                color: ColorsManager.lightBlue,
              ),
            )
          : Container(
              color: context.read<AppCubit>().currentThemeMode == ThemeMode.dark
                  ? ColorsManager.darkColor
                  : ColorsManager.whiteColor,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Text(
                      "Next",
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 4,
                      onDotClicked: (index) => controller.animateToPage(
                        index,
                        curve: Curves.ease,
                        duration: Duration(milliseconds: 500),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.animateToPage(
                        3,
                        curve: Curves.ease,
                        duration: Duration(milliseconds: 500),
                      );
                    },
                    child: Text(
                      "Skip",
                    ),
                  ),
                ],
              ),
            ),
      body: Container(
        padding: EdgeInsets.only(
          bottom: 80,
        ),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            if (index == 3) {
              setState(() {
                isLastIndex = true;
              });
            } else {
              setState(() {
                isLastIndex = false;
              });
            }
          },
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: SizedBox(
                    width: context.width,
                    height: context.height * 0.8,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            "https://i.imgur.com/kldXnVq.jpeg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: context.width,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          // color: ColorsManager.mainTeal,
                          ),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "Developed By",
                              style: MyTextStyles.font24Weight700(
                                  Theme.of(context)),
                            ),
                            Text(
                              "Mahmoud Osman",
                              style: MyTextStyles.font32Bold(Theme.of(context)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            BuildPageView(
              color: Colors.lightBlue,
              text: "Chocks Section",
              subText: translatedText(
                context: context,
                arabicText: "هنا الجزء الخاص بجميع المعلومات الخاصة بالكرسي",
                englishText: "Here is the chocks section",
              ),
              imagePath: "assets/images/bdm.jpg",
            ),
            BuildPageView(
              color: Colors.lightBlue,
              text: "Parts Section",
              subText: translatedText(
                context: context,
                arabicText:
                    "هنا الجزء الخاص بجميع المعلومات الخاصة بالأجزاء المسجلة برقم Material number فريد و تقدر تبحث عن اي قطعة بالرقم الخاص بها",
                englishText:
                    "Here is the section for the whole parts informations, and you can search for every part you want by it's material number",
              ),
              imagePath: "assets/images/list.jpg",
            ),
            BuildPageView(
              color: ColorsManager.darkColor,
              text: translatedText(
                context: context,
                arabicText: "تعليمات",
                englishText: "Instructions",
              ),
              subText: translatedText(
                context: context,
                arabicText: "ده الجزء الخاص باي تعليمات موجودة تخص الورشة",
                englishText:
                    "Here is the part that related to all structions in the rollshop",
              ),
              isSVG: true,
              imagePath: "assets/svgs/instructions.svg",
            ),
          ],
        ),
      ),
    );
  }
}
