import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/auth/cubit/auth_cubit.dart';

class ProfileScreen extends StatelessWidget {
  // final UserModel user;
  const ProfileScreen({
    super.key,
    // required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AuthCubit>().currentUser;
    return ConditionalBuilder(
      condition: currentUser != null,
      fallback: (context) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                TranslatedTextWidget(
                  arabicText: "برجاء تسجيل الدخول لرؤية ملفك الشخصي",
                  englishText: "Please sign in to see your profile",
                ),
                CustomButton(
                  buttonName: translatedText(
                    context: context,
                    arabicText: "تسجيل دخول",
                    englishText: "Sign in",
                  ),
                  onPressed: () {
                    context.pushNamed(Routes.loginScreen);
                  },
                  color: ColorsManager.orangeColor,
                ),
              ],
            ),
          ),
        );
      },
      builder: (context) {
        return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          // ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: context.width,
              child: Column(
                spacing: 20.r,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // currentUser != null
                  //     ? Text(
                  //         context.read<AuthCubit>().currentUser!.name,
                  //       )
                  //     : Text("User not signed in"),
                  // currentUser!.imagePath != null
                  //     ?
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: SizedBox(
                      width: context.width,
                      height: context.height / 3,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              currentUser!.imagePath ??
                                  "https://i.imgur.com/kldXnVq.jpeg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // : SizedBox(
                  //     child: GestureDetector(
                  //       onTap: () {},
                  //       child: Icon(Icons.upload),
                  //     ),
                  //   ),

                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 20.r,
                      end: 20.r,
                      bottom: 20.r,
                    ),
                    child: Column(
                      spacing: 20.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // currentUser!.imagePath != null
                        //     ? Align(
                        //         alignment: AlignmentDirectional.center,
                        //         child: CircleAvatar(
                        //           radius: 75.r,
                        //           backgroundImage: CachedNetworkImageProvider(
                        //             currentUser.imagePath!,
                        //           ),
                        //         ),
                        //       )
                        //     : Align(
                        //         alignment: AlignmentDirectional.center,
                        //         child: CircleAvatar(
                        //           radius: 75.r,
                        //           child: Icon(
                        //             Icons.upload,
                        //             size: 50.r,
                        //           ),
                        //         ),
                        //       ),
                        BuildProfileInfo(
                          lable: Text(translatedText(
                            context: context,
                            arabicText: "الأسم",
                            englishText: "Name",
                          )),
                          info: currentUser.name,
                        ),
                        BuildProfileInfo(
                          lable: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                translatedText(
                                  context: context,
                                  arabicText: "البريد الالكتروني",
                                  englishText: "Email Address",
                                ),
                              ),
                              Text(
                                currentUser.isEmailVerified!
                                    ? translatedText(
                                        context: context,
                                        arabicText: "تم التفعيل",
                                        englishText: "Verified",
                                      )
                                    : translatedText(
                                        context: context,
                                        arabicText: "غير مفعل",
                                        englishText: "Not Verified",
                                      ),
                                style: MyTextStyles.font14OrangeOrRedBold(
                                        Theme.of(context))
                                    .copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          info: currentUser.email,
                        ),
                        BuildProfileInfo(
                          lable: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                translatedText(
                                  context: context,
                                  arabicText: "رقم الموبايل",
                                  englishText: "Phone Number",
                                ),
                              ),
                              Text(
                                currentUser.isPhoneVerified!
                                    ? translatedText(
                                        context: context,
                                        arabicText: "تم التفعيل",
                                        englishText: "Verified",
                                      )
                                    : translatedText(
                                        context: context,
                                        arabicText: "غير مفعل",
                                        englishText: "Not Verified",
                                      ),
                                style: MyTextStyles.font14OrangeOrRedBold(
                                        Theme.of(context))
                                    .copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          info: currentUser.phoneNumber,
                        ),
                        // currentUser.isEmailVerified != null
                        //     ? BuildProfileInfo(
                        //         lable: translatedText(
                        //           context: context,
                        //           arabicText: "حالة البريد الالكتروني",
                        //           englishText: "Is email virefied?",
                        //         ),
                        //         info: currentUser.isEmailVerified! == true
                        //             ? translatedText(
                        //                 context: context,
                        //                 arabicText: "تم التفعيل",
                        //                 englishText: "Verified",
                        //               )
                        //             : translatedText(
                        //                 context: context,
                        //                 arabicText: "غير مفعل",
                        //                 englishText: "Not Verified",
                        //               ),
                        //       )
                        //     : SizedBox(),
                        // BuildProfileInfo(
                        //   lable: Text(
                        //     translatedText(
                        //       context: context,
                        //       arabicText: "رقم الموبايل",
                        //       englishText: "Phone Number",
                        //     ),
                        //   ),
                        //   info: currentUser.phoneNumber,
                        // ),
                        BuildProfileInfo(
                          lable: Text(translatedText(
                            context: context,
                            arabicText: "الوظيفة",
                            englishText: "position",
                          )),
                          info: currentUser.userType,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class BuildProfileInfo extends StatelessWidget {
  const BuildProfileInfo({
    super.key,
    required this.lable,
    required this.info,
  });

  final Widget lable;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        lable,
        Text(
          info,
          style: MyTextStyles.font16Weight500(Theme.of(context)),
        ),
      ],
    );
  }
}
