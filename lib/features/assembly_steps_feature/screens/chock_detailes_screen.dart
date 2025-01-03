import 'package:flutter/material.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/assembly_steps_feature/models/chock_type_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChockDetailesScreen extends StatelessWidget {
  ChockTypesModel chock;
  ChockDetailesScreen({
    super.key,
    required this.chock,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(chock.name),
      //   titleTextStyle: MyTextStyles.font32WhiteBold,
      //   centerTitle: true,
      //   backgroundColor: ColorsManager.darkModeColor,
      // ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: size.height / 4,
                  width: size.width,
                  child: Image.asset(
                    chock.chockImagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                "خطوات التجميع",
                style: MyTextStyles.font32WhiteBold,
              ),
              SizedBox(
                height: size.height / 3,
                child: ListView.builder(
                  itemCount: chock.assemblySteps.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(
                          chock.assemblySteps[index].description,
                          style: MyTextStyles.font16WhiteWeight500,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 200,
                          width: size.width,
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 10,
                              );
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                chock.assemblySteps[index].imagesPath.length,
                            itemBuilder: (context, indexImage) => ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                chock.assemblySteps[index]
                                    .imagesPath[indexImage],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
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
                    style: MyTextStyles.font32WhiteBold,
                  ),
                  Text(
                    ":ملاحظات",
                    style: MyTextStyles.font32WhiteBold,
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
