import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/router/app_router.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/features/chock_feature/screens/add_chock_screen.dart';
import 'package:rollshop/features/chock_feature/view_model/chock_cubit.dart';
import 'package:rollshop/features/chock_feature/view_model/chock_state.dart';
import 'package:rollshop/features/chock_feature/models/chock_type_model.dart';

import '../../../core/theme/styles.dart';

class AllChocksScreen extends StatefulWidget {
  AllChocksScreen({super.key});

  @override
  State<AllChocksScreen> createState() => _AllChocksScreenState();
}

class _AllChocksScreenState extends State<AllChocksScreen> {
  @override
  void initState() {
    sl<ChockCubit>().loadAllChocks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChockCubit, ChockState>(
        bloc: sl<ChockCubit>(),
        builder: (context, state) {
          // if (state is ChocksLoadedSuccessfullyState) {
          //   chocks = state.chocks;
          // }
          if (state is ChocksLoadingState || state is ChocksInitialState) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (state is ChocksLoadedFailedState) {
            // Handle error state, e.g., display an error message
            return Center(child: Text('Error: ${state.error}'));
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
                onPressed: () {
                  // context.pushNamed(Routes.addPartWithMaterialNumberScreen);
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
                condition: sl<ChockCubit>().chocks.isNotEmpty,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: GridView.builder(
                      itemCount: sl<ChockCubit>().chocks.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .7,
                      ),
                      itemBuilder: (context, index) => SizedBox(
                        child: InkWell(
                          onTap: () {
                            context.pushNamed(
                              Routes.chockDetailesScreen,
                              arguments: sl<ChockCubit>().chocks[index],
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
                                      sl<ChockCubit>()
                                          .chocks[index]
                                          .chockImagePath,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                        sl<ChockCubit>().chocks.first.name),
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
