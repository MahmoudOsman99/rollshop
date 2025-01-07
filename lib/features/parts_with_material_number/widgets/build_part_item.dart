import 'package:flutter/material.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';

class BuildPartItem extends StatelessWidget {
  BuildPartItem({
    super.key,
    required this.partsWithMaterialNumberModel,
  });
  PartsWithMaterialNumberModel partsWithMaterialNumberModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "الأسم:",
            ),
            Text(
              partsWithMaterialNumberModel.name,
            ),
          ],
        ),
      ],
    );
  }
}
