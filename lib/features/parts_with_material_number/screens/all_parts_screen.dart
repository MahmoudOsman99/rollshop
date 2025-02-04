import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/components/widgets/snack_bar.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';

import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';
import 'package:rollshop/features/parts_with_material_number/cubit/parts_cubit.dart';
import 'package:rollshop/features/parts_with_material_number/cubit/parts_state.dart';
import 'package:rollshop/features/parts_with_material_number/widgets/build_part_item.dart';

class AllPartsScreen extends StatelessWidget {
  AllPartsScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    // final partCubit = PartsCubit.get(context);
    return BlocBuilder<PartsCubit, PartsState>(
      bloc: context.read<PartsCubit>(),
      builder: (context, state) {
        if (state is PartsInitialState) {
          // context.read<PartsCubit>().getAllParts();
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (state is PartsLoadingState || state is PartWatingState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        // else if (state is PartAddeddSuccessfullyState) {
        //   showCustomSnackBar(
        //     context: context,
        //     message: "تم اضافة العنصر بنجاح",
        //     color: ColorsManager.mainTeal,
        //   );
        // }
        else {
          return Scaffold(
            appBar: AppBar(
              title: FittedBox(
                child: TranslatedTextWidget(
                  arabicText: "جميع العناصر المسجلة",
                  englishText: "All Parts",
                  textStyle: MyTextStyles.font32Bold(Theme.of(context))
                      .copyWith(color: ColorsManager.lightWhite),
                ),
                // Text(
                //   'جميع العناصر المسجلة ${context.read<PartsCubit>().parts.length}',
                //   // 'Parts Section ${parts.length}',
                //   style: MyTextStyles.font32Bold(Theme.of(context))
                //       .copyWith(color: ColorsManager.lightWhite),
                // ),
              ),
              centerTitle: true,
              backgroundColor:
                  context.read<AppCubit>().currentThemeMode == ThemeMode.dark
                      ? ColorsManager.lightBlue
                      : ColorsManager.orangeColor,
              //  ColorsManager.lightBlue,
              leading: IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchdelegate(),
                  );
                },
                icon: Icon(Icons.search),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.pushNamed(Routes.addNewPart);
                // context.pushNamed(Routes.addPartsScreen);
                //   context.read<PartsCubit>()addOneParts(newParts: null);
                //   context.read<PartsCubit>()loadAllChocks();
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
                condition: context.read<PartsCubit>().parts.isNotEmpty,
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
                builder: (context) {
                  if (state is PartAddeddSuccessfullyState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showCustomSnackBar(
                          context: context,
                          message: "تم اضافة ${state.partName} بنجاح",
                          color: ColorsManager.mainTeal);
                    }
                        // if (someCondition) {
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //       content: Text("تم اضافة ${state.partName} بنجاح")));
                        //   // }
                        // }
                        );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      await context.read<PartsCubit>().getAllParts();
                    },
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BuildPartItem(
                          part: context.read<PartsCubit>().parts[index],
                          allowEdit: true,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: context.read<PartsCubit>().parts.length,
                    ),
                  );
                }),
          );
          // return Scaffold(
          //   body: Center(
          //     child: Text("No data found"),
          //   ),
          // );
        }
      },
    );
  }
}

class CustomSearchdelegate extends SearchDelegate {
  // PartsWithMaterialNumberModel
  // String _searchQuery = "";
  // List<PartsWithMaterialNumberModel> parts = sl<PartsCubit>().parts;
  // List<PartsWithMaterialNumberModel> get _filteredParts {
  //   if (_searchQuery.isEmpty) {
  //     return parts; // Use widget.allParts
  //   } else {
  //     final lowerCaseQuery = _searchQuery.toLowerCase();
  //     return parts
  //         .where(
  //           (part) =>
  //               part.materialNumber.toString().contains(lowerCaseQuery) ||
  //               part.name.toLowerCase().contains(lowerCaseQuery) ||
  //               part.areaOfUsage.toLowerCase().contains(lowerCaseQuery) ||
  //               part.type.toLowerCase().contains(lowerCaseQuery),
  //         )
  //         .toList();
  //   }
  // }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.adaptive.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // List<PartsWithMaterialNumberModel> foundedParts = [];
    // query
    // if(parts.where((p) => p.materialNumber == query)){}
    final lowerCaseQuery = query;
    // return Text(lowerCaseQuery);
    // debugPrint(lowerCaseQuery);
    // if (_searchQuery.isNotEmpty) {
    // debugPrint(foundedParts.length.toString());
    // _filteredParts.add();

    return BlocBuilder<PartsCubit, PartsState>(
      builder: (context, state) {
        debugPrint(lowerCaseQuery);

        final filteredParts = context
            .read<PartsCubit>()
            .parts
            .where((part) =>
                part.name.contains(lowerCaseQuery) ||
                part.materialNumber.toString().contains(lowerCaseQuery) ||
                part.areaOfUsage.contains(lowerCaseQuery) ||
                part.sizes.contains(lowerCaseQuery) ||
                part.type.contains(lowerCaseQuery))
            .toList();

        // .where(
        //   (part) => part.name.toString() == lowerCaseQuery,
        // )
        // .toList();
        return _buildResultList(filteredParts);
      },
    );

    // return _buildResultList(foundedParts);
    // final foundedParts = parts
    //     .where((part) =>
    //         part.name.contains(lowerCaseQuery) ||
    //         part.materialNumber.toString().contains(lowerCaseQuery) ||
    //         part.areaOfUsage.contains(lowerCaseQuery) ||
    //         part.sizes.contains(lowerCaseQuery) ||
    //         part.type.contains(lowerCaseQuery))
    //     .toList();
    // }

    // return SizedBox(
    //   child: Text("Founded"),
    // );
    // return SizedBox(
    //   width: context.width,
    //   height: context.height * .5,
    //   child: ListView.builder(
    //     itemCount: _filteredParts.length,
    //     itemBuilder: (context, index) {
    //       return BuildPartItem(
    //         allowEdit: true,
    //         part: _filteredParts[index],
    //       );
    //     },
    //   ),
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // return SizedBox();
    return BlocBuilder<PartsCubit, PartsState>(
      builder: (context, state) {
        List<PartsWithMaterialNumberModel> parts =
            context.read<PartsCubit>().parts; // Get the parts from the cubit
        final lowerCaseQuery = query.toLowerCase();
        final filteredParts = query.isEmpty
            ? parts.take(2).toList() // Show first 5 if query is empty
            : parts
                .where((part) =>
                    part.materialNumber
                        .toString()
                        .toLowerCase()
                        .startsWith(lowerCaseQuery) ||
                    part.name.toLowerCase().contains(lowerCaseQuery) ||
                    part.type.toLowerCase().contains(lowerCaseQuery) ||
                    part.sizes.toLowerCase().contains(lowerCaseQuery) ||
                    part.sizes.toLowerCase().contains(lowerCaseQuery))
                .toList();

        return _buildResultList(filteredParts);
      },
    );
  }

  Widget _buildResultList(List<PartsWithMaterialNumberModel> parts) {
    // Extracted function
    if (parts.isEmpty) {
      return const Center(child: Text('No parts found'));
    }
    return ListView.builder(
      itemCount: parts.length,
      itemBuilder: (context, index) {
        return BuildPartItem(
          allowEdit: true,
          part: parts[index],
          // onTap: () {
          //   close(context, parts[index]); // Return the selected part
          // },
        );
      },
    );
  }
}

// class CustomSearchDelegate extends SearchDelegate {
//   CustomSearchDelegate();
//   List<ChockTypesModel> chocks = sl<ChockCubit>().chocks;
//   // List<ChockTypesModel> chock = context.read<ChockCubit>().ge;
//   // List<String> suggestions = [
//   //   "USA",
//   //   "China",
//   //   "Australia",
//   // ];
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = "";
//         });
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         icon: Icon(Icons.adaptive.arrow_back),
//         onPressed: () => close(context, null));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     List<ChockTypesModel> matchQuery = [];

//     for (var suggestion in chocks) {
//       if (suggestion.name.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(suggestion);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         BuildChockItem(
//           chock: result,
//         );
//         // return ListTile(
//         //   title: Text(result.name),
//         // );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return ListView.builder(
//       itemCount: chocks.length,
//       itemBuilder: (context, index) {
//         final suggestion = chocks[index];

//         return SizedBox(
//           width: context.width,
//           height: context.height * 0.4,
//           child: ListView.separated(
//             itemBuilder: (context, index) => BuildChockItem(chock: suggestion),
//             itemCount: chocks.length,
//             separatorBuilder: (context, index) {
//               return Divider();
//             },
//           ),
//         );

//         // return ListTile(
//         //   title: Text(suggestion.name),
//         //   onTap: () {
//         //     query = suggestion.name;
//         //   },
//         // );
//       },
//     );
//   }
// }
