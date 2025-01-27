// select_parts_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';
import 'package:rollshop/features/parts_with_material_number/screens/add_parts_with_material_number_screen.dart';
import 'package:rollshop/features/parts_with_material_number/screens/all_parts_screen.dart';
import 'package:rollshop/features/parts_with_material_number/widgets/build_part_item.dart';
// ... other imports

class SelectPartsList extends StatefulWidget {
  final List<PartsWithMaterialNumberModel> allParts; // Receive all parts
  final Function(List<PartsWithMaterialNumberModel>) onPartsSelected;

  const SelectPartsList(
      {super.key, required this.allParts, required this.onPartsSelected});

  @override
  State<SelectPartsList> createState() => _SelectPartsListState();
}

class _SelectPartsListState extends State<SelectPartsList> {
  final List<String> _selectedPartIds = [];
  String _searchQuery = '';

  List<PartsWithMaterialNumberModel> get _filteredParts {
    if (_searchQuery.isEmpty) {
      return widget.allParts; // Use widget.allParts
    } else {
      final lowerCaseQuery = _searchQuery.toLowerCase();
      return widget.allParts
          .where(
            (part) =>
                part.materialNumber.toString().contains(lowerCaseQuery) ||
                part.name.toLowerCase().contains(lowerCaseQuery) ||
                part.areaOfUsage.toLowerCase().contains(lowerCaseQuery) ||
                part.type.toLowerCase().contains(lowerCaseQuery),
          )
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: ColorsManager.greyText,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: ColorsManager.orangeColor,
                    //  context.read<AppCubit>().currentThemeMode ==
                    //         ThemeMode.dark
                    //     ? ColorsManager.whiteColor
                    //     : ColorsManager.orangeColor,
                    width: 2,
                  ),
                ),
                hintText: 'Search parts...',
                prefixIcon: Icon(
                  Icons.search,
                ),
                hintTextDirection: TextDirection.ltr
                // border: OutlineInputBorder(),
                ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _filteredParts.length,
            itemBuilder: (context, index) {
              final part = _filteredParts[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    if (_selectedPartIds.contains(part.id)) {
                      _selectedPartIds.remove(part.id);
                    } else {
                      _selectedPartIds.add(part.id!);
                    }
                  });
                  final selectedParts = widget.allParts
                      .where((part) => _selectedPartIds.contains(part.id))
                      .toList();
                  widget.onPartsSelected(selectedParts);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40.w,
                        height: 40.h,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: _selectedPartIds.contains(part.id)
                                ? ColorsManager.orangeColor
                                : ColorsManager.greyText,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.check,
                            color: ColorsManager.whiteColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: BuildPartItem(
                          part: part,
                          allowEdit: false,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // ElevatedButton(
        //   // Add a "Done" button
        //   onPressed: () {
        //     final selectedParts = widget.allParts
        //         .where((part) => _selectedPartIds.contains(part.id))
        //         .toList();
        //     widget.onPartsSelected(selectedParts);
        //     // Navigator.pop(context);
        //   },
        //   child: const Text('Done'),
        // ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:rollshop/components/widgets/custom_button.dart';
// import 'package:rollshop/core/helpers/extensions.dart';
// import 'package:rollshop/core/theme/colors.dart';
// import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';
// import 'package:rollshop/features/parts_with_material_number/screens/all_parts_screen.dart';
// import 'package:rollshop/features/parts_with_material_number/view_model/cubit/parts_cubit.dart';

// class SelectPartsList extends StatefulWidget {
//   final Function(List<PartsWithMaterialNumberModel>) onPartsSelected;
//   const SelectPartsList({super.key, required this.onPartsSelected});

//   @override
//   State<SelectPartsList> createState() => _SelectPartsListState();
// }

// class _SelectPartsListState extends State<SelectPartsList> {
//   final List<String> _selectedPartsIds = [];
//   final List<String> _selectedPartIds = [];

//   String _searchQuery = ''; // Stores the search query

//   List<PartsWithMaterialNumberModel> get _filteredParts {
//     if (_searchQuery.isEmpty) {
//       return context.read<PartsCubit>().parts;
//     } else {
//       final lowerCaseQuery = _searchQuery.toLowerCase();
//       return context
//           .read<PartsCubit>()
//           .parts
//           .where((part) =>
//               part.materialNumber
//                   .toString()
//                   .toLowerCase()
//                   .contains(lowerCaseQuery) ||
//               part.name.toLowerCase().contains(lowerCaseQuery))
//           .toList();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             keyboardType: TextInputType.text,
//             onChanged: (value) {
//               setState(() {
//                 _searchQuery = value;
//               });
//             },
//             decoration: InputDecoration(
//               hintText: 'Search parts...',
//               prefixIcon: const Icon(Icons.search),
//               focusColor: ColorsManager.orangeColor,
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: ColorsManager.orangeColor,
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: ColorsManager.mainTeal,
//                   width: 3,
//                 ),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: _filteredParts.length,
//             itemBuilder: (context, index) {
//               final part = _filteredParts[index];
//               final originalIndex = context
//                   .read<PartsCubit>()
//                   .parts
//                   .indexOf(part); // Get original index
//               return Padding(
//                 padding: EdgeInsets.all(8.0.sp),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 1,
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             if (_selectedPartIds.contains(originalIndex)) {
//                               _selectedPartIds.remove(originalIndex);
//                             } else {
//                               _selectedPartIds.add(originalIndex);
//                             }
//                           });
//                         },
//                         child: SizedBox(
//                           child: Icon(
//                             Icons.check,
//                             color: _selectedPartsIds.contains(originalIndex)
//                                 ? ColorsManager.orangeColor
//                                 : ColorsManager.greyText,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 5,
//                       child: BuildPartItem(
//                         part: part,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         SizedBox(
//           height: 30,
//         ),
//         CustomButton(
//           buttonName: "See selected parts",
//           onPressed: () {
//             final allParts = context.read<PartsCubit>().parts;
//             final selectedParts = allParts
//                 .where((part) => _selectedPartsIds.contains(part.id))
//                 .toList();
//             widget.onPartsSelected(selectedParts);

//             // context.pop();
//           },
//           color: ColorsManager.orangeColor,
//         ),
//       ],
//     );
//   }
// }

// // // In your parent widget
// // List<PartsWithMaterialNumberModel> getSelectedParts(BuildContext context) {
// //   final selectPartsListState =
// //       context.findAncestorStateOfType<_SelectPartsListState>();
// //   if (selectPartsListState != null) {
// //     final partsCubit = context.read<PartsCubit>();
// //     return selectPartsListState._selectedPartsIds
// //         .map((index) => partsCubit.parts[index])
// //         .toList();
// //   }
// //   return [];
// // }
