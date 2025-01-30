import 'package:flutter/material.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/chock_feature/models/chock_type_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PartDetailesScreen extends StatelessWidget {
  final ChockTypesModel chock;
  const PartDetailesScreen({
    super.key,
    required this.chock,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(chock.name),
      //   titleTextStyle: MyTextStyles.font32WhiteBold,
      //   centerTitle: true,
      //   backgroundColor: ColorsManager.darkModeColor,
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.read<ChockCubit>().addOneChock(newChock: null);
          context.pushNamed(Routes.addChockScreen);
        },
        backgroundColor: ColorsManager.orangeColor,
        child: Icon(
          Icons.add,
          color: ColorsManager.whiteColor,
          size: 50,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: context.height / 4,
                    width: context.width,
                    child: Image.asset(
                      chock.chockImagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  "خطوات التجميع",
                  style: MyTextStyles.font24Weight700(Theme.of(context)),
                ),
                if (chock.assemblySteps.isNotEmpty)
                  SizedBox(
                    height: context.height / 2,
                    child: ListView.builder(
                      itemCount: chock.assemblySteps.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text(
                              chock.assemblySteps[index].description,
                              style: MyTextStyles.font16BlackeWeight500,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // SizedBox(
                            //   height: context.height / 3,
                            //   width: context.width,
                            //   child: ListView.separated(
                            //     separatorBuilder: (context, index) {
                            //       return SizedBox(
                            //         width: 10,
                            //         height: 20,
                            //       );
                            //     },
                            //     scrollDirection: Axis.vertical,
                            //     itemCount: chock
                            //         .assemblySteps[index].imagesPath.length,
                            //     itemBuilder: (context, indexImage) => ClipRRect(
                            //       borderRadius: BorderRadius.circular(15),
                            //       child: InteractiveViewer(
                            //         minScale: 1.0,
                            //         maxScale: 4.0,
                            //         child: Image.asset(
                            //           chock.assemblySteps[index]
                            //               .imagesPath[indexImage],
                            //           fit: BoxFit.cover,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        );
                      },
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  spacing: 10.sp,
                  children: [
                    Text(
                      chock.notes,
                      style: MyTextStyles.font32OrangeBold,
                    ),
                    Text(
                      ":ملاحظات",
                      style: MyTextStyles.font32OrangeBold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
