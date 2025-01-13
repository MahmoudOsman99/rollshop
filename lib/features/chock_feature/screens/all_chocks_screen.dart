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

import 'package:rollshop/features/chock_feature/view_model/chock_cubit.dart';
import 'package:rollshop/features/chock_feature/view_model/chock_state.dart';
import 'package:rollshop/features/parts_with_material_number/view_model/cubit/parts_cubit.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChockCubit, ChockState>(
        bloc: context.read<ChockCubit>(),
        builder: (context, state) {
          // if (state is ChocksLoadedSuccessfullyState) {
          //   chocks = state.chocks;
          // }
          if (state is ChocksInitialState) {
            context.read<ChockCubit>().loadAllChocks();
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (state is ChocksLoadedFailedState) {
            // Handle error state, e.g., display an error message
            return Scaffold(body: Center(child: Text('Error: ${state.error}')));
          } else if (state is ChocksLoadedSuccessfullyState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'BDM Section',
                  style: MyTextStyles.font32WhiteBold,
                ),
                centerTitle: true,
                backgroundColor: ColorsManager.mainTeal,
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
                backgroundColor: ColorsManager.orangeColor,
                child: Icon(Icons.add),
              ),
              body: ConditionalBuilder(
                fallback: (context) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                condition: state.chocks.isNotEmpty,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: GridView.builder(
                      itemCount: state.chocks.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .7,
                      ),
                      itemBuilder: (context, index) => SizedBox(
                        child: Card(
                          elevation: 20,
                          child: InkWell(
                            onTap: () {
                              context.pushNamed(
                                Routes.chockDetailesScreen,
                                arguments: state.chocks[index],
                              );
                            },
                            child: Column(
                              spacing: 10.h,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top:
                                          0), // to let the image in the top without auto padding
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: SizedBox(
                                      width: context.width * .5,
                                      height: context.height * .2,
                                      child: BuildImageWithErrorHandler(
                                        imageType: ImageType.network,
                                        boxFit: BoxFit.cover,
                                        path:
                                            state.chocks[index].chockImagePath,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 10.h,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.chocks[index].name,
                                        style: MyTextStyles.font16BlackeBold,
                                      ),
                                      Text(
                                        state.chocks[index].notes,
                                        style: MyTextStyles.font13GreyRegular,
                                      ),
                                      state.chocks[index].bearingType.isNotEmpty
                                          ? Text(
                                              state.chocks[index].bearingType,
                                              style: MyTextStyles
                                                  .font13GreyRegular,
                                            )
                                          : SizedBox(),
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(15),
                                      //     child: Text(state.chocks.first.name),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Text("unexpected error founded");
          }
        });
  }
}
