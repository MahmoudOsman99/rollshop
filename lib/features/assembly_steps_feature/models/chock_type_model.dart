import 'package:rollshop/features/assembly_steps_feature/models/assembly_steps_model.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';

class ChockTypesModel {
  final String? id;
  final String name;
  final String chockImagePath;
  final String notes;
  // final String? howTocalcBearingShim;
  final List<AssemblyStepsModel> assemblySteps;
  final List<PartsWithMaterialNumberModel>? parts;
  // final String assemblySteps;

  ChockTypesModel({
    this.id,
    required this.name,
    required this.chockImagePath,
    required this.notes,
    required this.assemblySteps,
    // this.howTocalcBearingShim,
    this.parts,
  });

  factory ChockTypesModel.fromJson(
      {required Map<String, dynamic> json, idFromFirebase}) {
    return ChockTypesModel(
      id: idFromFirebase ?? json['id'] as String ?? [0],
      name: json['name'] as String,
      chockImagePath: json['chockImagePath'] as String,
      notes: json['notes'] as String,
      // howTocalcBearingShim: json['howTocalcBearingShim'] as String,
      assemblySteps: (json['assemblySteps'] as List<dynamic>?)
              ?.map((step) => AssemblyStepsModel.fromJson(
                  json: step as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'chockImagePath': chockImagePath,
      'notes': notes,
      'assemblySteps': assemblySteps.map((step) => step.toJson()).toList(),
    };
  }
}

// Future<void> _loadChockTypes() async {
//   // Simulate loading from JSON (you'd usually load from a file or network)
//   String jsonString = '''
//       [
//         {"name": "Top of Stroke", "imagePath": "assets/images/tos.png"},
//         {"name": "Bottom of Stroke", "imagePath": "assets/images/bos.png"},
//         {"name": "Top Dead Stroke", "imagePath": "assets/images/tds.png"},
//         {"name": "Bottom Dead Stroke", "imagePath": "assets/images/bds.png"},
//         {"name": "Top Thrust Chock", "imagePath": "assets/images/top_thrust.png"},
//         {"name": "Bottom Thrust Chock", "imagePath": "assets/images/bottom_thrust.png"},
//         {"name": "Piston", "imagePath": "assets/images/piston.png"}
//       ]
//     ''';
// }
