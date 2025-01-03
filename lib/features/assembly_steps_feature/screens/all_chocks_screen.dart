import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/features/assembly_steps_feature/models/assembly_steps_model.dart';
import 'package:rollshop/features/assembly_steps_feature/view_model/chock_cubit.dart';
import 'package:rollshop/features/assembly_steps_feature/view_model/chock_state.dart';
import 'package:rollshop/features/main/chock_type_enum.dart';
import 'package:rollshop/features/assembly_steps_feature/models/chock_type_model.dart';
import 'package:rollshop/core/helpers/images_path.dart';

import '../../../core/theme/styles.dart';

class AllChocksScreen extends StatelessWidget {
  AllChocksScreen({super.key});
  List<String> sectionsName = [
    "BDM",
    "TDM",
    "Vertical",
    "Straightener",
  ];
  List chockTypesNames = ChockTypeEnumDetailes.getNames();
  List chockTypes = ChockTypes.values;
  List<ChockTypesModel> chocks = [];

  @override
  Widget build(BuildContext context) {
    // debugPrint(
    //     'assets/images/chock_types/${ChockTypes.BDS.name.toLowerCase()}.jpg');
    return BlocConsumer<ChockCubit, ChockState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ChocksLoadedSuccessfullyState) {
          chocks = state.chocks;
          debugPrint(chocks.first.name);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'BDM Section',
              style: MyTextStyles.font32WhiteBold,
            ),
            centerTitle: true,
            backgroundColor: ColorsManager.mainBlue,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // context.read<ChockCubit>().addOneChock(newChock: null);
              context.read<ChockCubit>().loadAllChocks();
            },
            backgroundColor: ColorsManager.mainBlue,
            child: Icon(Icons.abc),
          ),
          body: ConditionalBuilder(
            fallback: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            condition: chocks.isNotEmpty,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.all(10.sp),
                child: PageView(
                  children: [
                    GridView.builder(
                      itemCount: chocks.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .7,
                      ),
                      itemBuilder: (context, index) => SizedBox(
                        child: InkWell(
                          onTap: () {
                            context.pushNamed(
                              Routes.chockDetailesScreen,
                              arguments: chocks[index],
                            );
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.sp),
                                    child: Image.asset(
                                      chocks[index].chockImagePath,
                                      // 'assets/images/chock_types/${chockTypes[index]}.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(chocks.first.name),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "TDM",
                      style: MyTextStyles.font32WhiteBold,
                    ),
                    Text(
                      "Vertical",
                      style: MyTextStyles.font32WhiteBold,
                    ),
                    Text(
                      "Straightener",
                      style: MyTextStyles.font32WhiteBold,
                    ),
                    Text(
                      "Guides",
                      style: MyTextStyles.font32WhiteBold,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
