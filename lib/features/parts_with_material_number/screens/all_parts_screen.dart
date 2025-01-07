import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/helpers/images_path.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';

import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';
import 'package:rollshop/features/parts_with_material_number/view_model/cubit/parts_cubit.dart';
import 'package:rollshop/features/parts_with_material_number/view_model/cubit/parts_state.dart';

class AllPartsScreen extends StatelessWidget {
  AllPartsScreen({super.key});

  // List<PartsWithMaterialNumberModel> parts = [];

  @override
  Widget build(BuildContext context) {
    final partCubit = PartsCubit.get(context);
    return BlocConsumer<PartsCubit, PartsState>(
      listener: (context, state) {
        // TODO: implement listener
        // if (state is PartsLoadedSuccessfullyState) {
        //   parts = state.parts;
        //   debugPrint(parts.first.name);
        // }
      },
      builder: (context, state) {
        if (state is PartsLoadingState || state is PartsInitialState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is PartsLoadedSuccessfullyState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Parts Section ${partCubit.parts.length}',
                // 'Parts Section ${parts.length}',
                style: MyTextStyles.font32WhiteBold,
              ),
              centerTitle: true,
              backgroundColor: ColorsManager.mainTeal,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.pushNamed(Routes.addPartWithMaterialNumberScreen);
                // context.pushNamed(Routes.addPartsScreen);
                // context.read<PartsCubit>().addOneParts(newParts: null);
                // context.read<PartsCubit>().loadAllChocks();
              },
              backgroundColor: ColorsManager.orangeColor,
              child: Icon(Icons.add),
            ),
            body: ConditionalBuilder(
              fallback: (context) {
                if (partCubit.parts.isEmpty) {
                  return Center(
                    child: Text(
                      "No parts yet",
                      style: MyTextStyles.font32OrangeBold,
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              condition: partCubit.parts.isNotEmpty,
              builder: (context) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return BuildPartItem(
                      part: partCubit.parts[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 10,
                    );
                  },
                  itemCount: partCubit.parts.length,
                );

                // return GridView.builder(
                //   scrollDirection: Axis.vertical,
                //   itemCount: parts.length,
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 1,
                //   ),
                //   itemBuilder: (context, index) {
                //     debugPrint(parts[index].id);
                //     return BuildPartItem(
                //       part: parts[index],
                //     );
                //   },
                // );
              },
            ),
          );
        } else {
          return Center(
            child: Text(
              "No parts yet",
              style: MyTextStyles.font32OrangeBold,
            ),
          );
        }
      },
    );
  }
}

class BuildPartItem extends StatelessWidget {
  const BuildPartItem({
    super.key,
    required this.part,
  });

  final PartsWithMaterialNumberModel part;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("Pressed");
        context.pushNamed(Routes.editPartScreen, arguments: part);
      },
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildPartItem(text: part.name, lable: "الأسم:"),
                  buildPartItem(
                      text: part.materialNumber, lable: "رقم ماتريال:"),
                  buildPartItem(
                      text: part.drawingPartNumber, lable: "رقم الرسمة"),
                  buildPartItem(text: part.sizes, lable: "المقاسات"),
                  buildPartItem(text: part.type, lable: "النوع"),
                ],
              ),
            ),
            SizedBox(
              width: 120.sp,
              height: 120.sp,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: part.imagePath.isNotEmpty
                    ? BuildImageWithErrorHandler(
                        imageType: ImageType.network,
                        // path: parts[index].imagePath,
                        path: part.imagePath,
                        boxFit: BoxFit.cover,
                      )
                    : SizedBox(
                        child: Center(
                          child: Text(
                            "No Image",
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildPartItem({required dynamic text, required String lable}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        lable,
        style: MyTextStyles.font12BlackeBold,
      ),
      Flexible(
        child: Text(
          text.toString(),
          textDirection: TextDirection.ltr,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    ],
  );
}
