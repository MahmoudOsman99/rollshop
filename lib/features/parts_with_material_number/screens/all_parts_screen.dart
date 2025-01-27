import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:rollshop/features/main/cubit/app_cubit.dart';

import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';
import 'package:rollshop/features/parts_with_material_number/cubit/parts_cubit.dart';
import 'package:rollshop/features/parts_with_material_number/cubit/parts_state.dart';
import 'package:rollshop/features/parts_with_material_number/widgets/build_part_item.dart';
import 'package:rollshop/injection_container.dart';

class AllPartsScreen extends StatefulWidget {
  AllPartsScreen({super.key});

  @override
  State<AllPartsScreen> createState() => _AllPartsScreenState();
}

class _AllPartsScreenState extends State<AllPartsScreen> {
  // @override
  // void initState() {
  //   sl<PartsCubit>().getAllParts();
  //   super.initState();
  // }

  // List<PartsWithMaterialNumberModel> parts = [];
  @override
  Widget build(BuildContext context) {
    // final partCubit = PartsCubit.get(context);
    return BlocBuilder<PartsCubit, PartsState>(
      bloc: context.read<PartsCubit>(),
      builder: (context, state) {
        if (state is PartsInitialState) {
          context.read<PartsCubit>().getAllParts();
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is PartsLoadingState || state is PartWatingState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is PartsLoadedSuccessfullyState) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'جميع العناصر المسجلة ${state.parts.length}',
                  // 'Parts Section ${parts.length}',
                  style: MyTextStyles.font32Bold(Theme.of(context))
                      .copyWith(color: ColorsManager.lightWhite),
                ),
                centerTitle: true,
                backgroundColor:
                    context.read<AppCubit>().currentThemeMode == ThemeMode.dark
                        ? ColorsManager.lightBlue
                        : ColorsManager.orangeColor,
                //  ColorsManager.lightBlue,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.pushNamed(Routes.addPartWithMaterialNumberScreen);
                  // context.pushNamed(Routes.addPartsScreen);
                  // state.addOneParts(newParts: null);
                  // state.loadAllChocks();
                },
                backgroundColor:
                    context.read<AppCubit>().currentThemeMode == ThemeMode.dark
                        ? ColorsManager.lightBlue
                        : ColorsManager.orangeColor,
                //  ColorsManager.mainBlue,
                child: Icon(
                  Icons.add,
                  size: 25.sp,
                  color: ColorsManager.whiteColor,
                ),
              ),
              body: ConditionalBuilder(
                condition: state.parts.isNotEmpty,
                fallback: (context) {
                  return Scaffold(
                    body: Center(
                      child: Text(
                        "No parts yet",
                        style: MyTextStyles.font32OrangeBold,
                      ),
                    ),
                  );
                },
                builder: (context) => RefreshIndicator(
                  onRefresh: () async {
                    await context.read<PartsCubit>().getAllParts();
                  },
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BuildPartItem(
                        part: state.parts[index],
                        allowEdit: true,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                    itemCount: state.parts.length,
                  ),
                ),
              ));
        } else {
          return Scaffold(
            body: Center(
              child: Text("No data found"),
            ),
          );
        }
      },
    );
  }
}
