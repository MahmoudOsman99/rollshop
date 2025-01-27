import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/core/helpers/extensions.dart';

import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';

import 'package:rollshop/features/chock_feature/cubit/chock_cubit.dart';
import 'package:rollshop/features/chock_feature/cubit/chock_state.dart';
import 'package:rollshop/features/chock_feature/widgets/build_chock_item.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';
import 'package:rollshop/features/parts_with_material_number/cubit/parts_cubit.dart';

import '../../../core/theme/styles.dart';

class AllChocksScreen extends StatefulWidget {
  const AllChocksScreen({super.key});

  @override
  State<AllChocksScreen> createState() => _AllChocksScreenState();
}

class _AllChocksScreenState extends State<AllChocksScreen> {
  // @override
  // void initState() {
  //   sl<ChockCubit>().loadAllChocks();
  //   super.initState();
  // }
  // PersistentTabController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChockCubit, ChockState>(
        bloc: context.read<ChockCubit>(),
        builder: (context, state) {
          // if (state is ChocksLoadedSuccessfullyState) {
          //   chocks = state.chocks;
          // }
          if (state is ChocksInitialState) {
            context.read<ChockCubit>().getAllChocks();
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is ChocksLoadedFailedState) {
            // Handle error state, e.g., display an error message
            return Scaffold(body: Center(child: Text('Error: ${state.error}')));
          } else if (state is ChocksLoadingState) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is ChocksLoadedSuccessfullyState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'معلومات عن الكراسي',
                  style: MyTextStyles.font32Bold(Theme.of(context))
                      .copyWith(color: ColorsManager.whiteColor),
                ),
                centerTitle: true,
                backgroundColor:
                    context.read<AppCubit>().currentThemeMode == ThemeMode.dark
                        ? ColorsManager.lightBlue
                        : ColorsManager.orangeColor,
                //  ColorsManager.lightBlue,
                // backgroundColor:
                //     context.read<AppCubit>().currentThemeMode == ThemeMode.dark
                //         ? ColorsManager.blackBackGround
                //         : ColorsManager.orangeColor,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  // context.pushNamed(Routes.addPartWithMaterialNumberScreen);
                  if (context.read<PartsCubit>().parts.isEmpty) {
                    await context.read<PartsCubit>().getAllParts();
                  }
                  context.pushNamed(Routes.addChockScreen);
                  // context.read<ChockCubit>().addOneChock(newChock: null);
                  // context.read<ChockCubit>().loadAllChocks();
                },
                backgroundColor:
                    context.read<AppCubit>().currentThemeMode == ThemeMode.dark
                        ? ColorsManager.lightBlue
                        : ColorsManager.orangeColor,
                //  ColorsManager.redAccent,
                // backgroundColor:
                //     context.read<AppCubit>().currentThemeMode == ThemeMode.dark
                //         ? ColorsManager.darkModeColor
                //         : ColorsManager.orangeColor,
                child: Icon(
                  Icons.add,
                  size: 25.sp,
                  color: context.read<AppCubit>().currentThemeMode ==
                          ThemeMode.dark
                      ? ColorsManager.whiteColor
                      : ColorsManager.blackText,
                ),
              ),
              body: ConditionalBuilder(
                fallback: (context) {
                  return Scaffold(
                    body: RefreshIndicator(
                      onRefresh: () {
                        return context.read<ChockCubit>().getAllChocks();
                      },
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: Text(
                            "لا توجد بيانات محفوظة. برجاء تسجيل بيانات الChock و حاول مرة اخري",
                            style:
                                MyTextStyles.font24Weight700(Theme.of(context)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                condition: state.chocks.isNotEmpty,
                builder: (context) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await context.read<ChockCubit>().getAllChocks();
                    },
                    child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: ListView.separated(
                          // physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BuildChockItem(chock: state.chocks[index]);
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color:
                                  context.read<AppCubit>().currentThemeMode ==
                                          ThemeMode.dark
                                      ? ColorsManager.deepGrey
                                      : ColorsManager.lightWhite,
                              //  ColorsManager.deepGrey,
                              thickness: 2,
                            );
                          },
                          itemCount: state.chocks.length,
                        )
                        // GridView.builder(
                        //   itemCount: state.chocks.length,
                        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 2,
                        //     childAspectRatio: .5,
                        //   ),
                        //   itemBuilder: (context, index) => DecoratedBox(
                        //     decoration: BoxDecoration(e4
                        //         color: ColorsManager.lightBlue,
                        //         borderRadius: BorderRadius.circular(10.r)
                        //         // borderRadius: BorderRadius.circular(10.r),
                        //         // border: Border.all(
                        //         // width: 2,
                        //         // color: ColorsManager.lightBlue,
                        //         // ),
                        //         ),
                        //     child: InkWell(
                        //       onTap: () {
                        //         context.pushNamed(
                        //           Routes.chockDetailesScreen,
                        //           arguments: state.chocks[index],
                        //         );
                        //       },
                        //       child: Column(
                        //         spacing: 10.h,
                        //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Padding(
                        //             padding: EdgeInsets.all(
                        //               5.r,
                        //             ), // to let the image in the top without auto padding
                        //             child: ClipRRect(
                        //               borderRadius: BorderRadiusDirectional.only(
                        //                 topEnd: Radius.circular(10.r),
                        //                 topStart: Radius.circular(10.r),
                        //                 bottomEnd: Radius.circular(10.r),
                        //                 bottomStart: Radius.circular(10.r),
                        //               ),
                        //               child: SizedBox(
                        //                 width: context.width * .5.w,
                        //                 height: context.height * .24.h,
                        //                 // height: 250.h,
                        //                 // width: 250.w,
                        //                 child: BuildImageWithErrorHandler(
                        //                   imageType: ImageType.network,
                        //                   boxFit: BoxFit.cover,
                        //                   path:
                        //                       state.chocks[index].chockImagePath,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           Expanded(
                        //             child: Padding(
                        //               padding: EdgeInsetsDirectional.only(
                        //                 start: 5.r,
                        //                 end: 5.r,
                        //               ),
                        //               child: Column(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.end,
                        //                 spacing: 10.h,
                        //                 // mainAxisAlignment: MainAxisAlignment.center,
                        //                 children: [
                        //                   Text(
                        //                     state.chocks[index].name,
                        //                     style: MyTextStyles.font16Bold(
                        //                         Theme.of(context)),
                        //                   ),
                        //                   // Text(
                        //                   //   state.chocks[index].notes,
                        //                   //   style: MyTextStyles.font13GreyRegular,
                        //                   //   maxLines: 1,
                        //                   //   overflow: TextOverflow.ellipsis,
                        //                   // ),
                        //                   DecoratedBox(
                        //                     decoration: BoxDecoration(
                        //                       color: ColorsManager.redAccent,
                        //                       borderRadius:
                        //                           BorderRadius.circular(5.r),
                        //                     ),
                        //                     child: Padding(
                        //                       padding: EdgeInsetsDirectional.only(
                        //                         start: 7.r,
                        //                         end: 7.r,
                        //                         top: 4.r,
                        //                         bottom: 4.r,
                        //                       ),
                        //                       child: Text(
                        //                         state.chocks[index].bearingType,
                        //                         style: MyTextStyles.font12Bold(
                        //                             Theme.of(context)),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   Text(
                        //                     state.chocks[index].notes,
                        //                     style: MyTextStyles.font13GreyRegular(
                        //                         Theme.of(context)),
                        //                   ),
                        //                   // state.chocks[index].bearingType
                        //                   //         .isNotEmpty
                        //                   //     ? Text(
                        //                   //         "نوع البيرنج:  ${state.chocks[index].bearingType}",
                        //                   //         style: MyTextStyles
                        //                   //             .font13GreyRegular,
                        //                   //       )
                        //                   //     : SizedBox(),
                        //                   // Expanded(
                        //                   //   flex: 1,
                        //                   //   child: Padding(
                        //                   //     padding: const EdgeInsets.all(15),
                        //                   //     child: Text(state.chocks.first.name),
                        //                   //   ),
                        //                   // ),
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        ),
                  );
                },
              ),
            );
          } else {
            // context.read<ChockCubit>().loadAllChocks();
            return RefreshIndicator(
              onRefresh: () => context.read<ChockCubit>().getAllChocks(),
              child: Scaffold(
                body: Center(
                  child: Text(
                    "Sorry! error happend and we will solve it ASAP",
                    style: MyTextStyles.font32OrangeBold,
                  ),
                ),
              ),
            );
          }
        });
  }
}
