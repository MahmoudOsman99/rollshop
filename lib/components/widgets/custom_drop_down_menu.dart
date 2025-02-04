import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/parts_with_material_number/screens/add_parts_with_material_number_screen.dart';

class CustomDropDown extends StatelessWidget {
  CustomDropDown({
    super.key,
    this.dropDownController,
    this.part,
    required this.items,
    required this.mainLable,
    required this.initialSelection,
    this.onSelected,
    this.icon,
    this.borderColor,
  });

  final TextEditingController? dropDownController;
  final AddPartWithMaterialNumberScreen? part;

  final Icon? icon;
  final Color? borderColor;
  List<DropdownMenuEntry> items;
  Widget mainLable;
  String initialSelection;
  ValueChanged<dynamic>? onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      controller: dropDownController,
      initialSelection: initialSelection,
      // initialSelection: part.isEdit ? part.partModel!.areaOfUsage : "BDM",
      width: context.width,
      onSelected: onSelected,
      leadingIcon: icon ?? Icon(Icons.settings_suggest_outlined),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: borderColor ?? ColorsManager.orangeColor,
            width: 2,
          ),
        ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10.r),
        //   borderSide: BorderSide(
        //     color: ColorsManager.orangeColor,
        //   ),
        // ),
      ),
      label: mainLable,
      dropdownMenuEntries: [
        ...items
        // DropdownMenuEntry(value: "BDM", label: "BDM"),
        // DropdownMenuEntry(value: "TDM", label: "TDM"),
        // DropdownMenuEntry(value: "Vertical", label: "Vertical"),
        // DropdownMenuEntry(value: "Straghitner", label: "Straghitner"),
        // DropdownMenuEntry(value: "Guides", label: "Guides"),
      ],
    );
  }
}
