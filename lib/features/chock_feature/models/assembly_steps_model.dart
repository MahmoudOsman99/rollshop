class AssemblyStepsModel {
  String? id;
  String description;
  String notes;
  List<String> imagesPath;
  // Map<String, dynamic> _data;
  // List<StepsDetailesModel> stepsDetailes;

  AssemblyStepsModel({
    this.id,
    required this.description,
    required this.imagesPath,
    required this.notes,

    // required this.stepsDetailes,
  });
  //  : _data = {
  //         "description": description,
  //         "notes": notes,
  //       };

  // dynamic operator [](String key) => _data[key];

  // Factory constructor to create a StepsDetailesModel from a JSON map
  factory AssemblyStepsModel.fromJson(
      {required Map<String, dynamic> json, idFromFirebase}) {
    return AssemblyStepsModel(
      id: idFromFirebase ?? json['description'] as String,
      description: json['description'] as String,
      notes: json['notes'] as String,
      imagesPath: List<String>.from(json['imagesPath'] as List),
    );
  }

  // Method to convert a StepsDetailesModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'imagesPath': imagesPath.toList(),
      'notes': notes,
    };
  }
}

// class StepsDetailesModel {
//   List<String> imagesPath;
//   String description;
//   String notes;

//   StepsDetailesModel({
//     required this.description,
//     required this.imagesPath,
//     required this.notes,
//   });

//   // Factory constructor to create a StepsDetailesModel from a JSON map
//   factory StepsDetailesModel.fromJson(Map<String, dynamic> json) {
//     return StepsDetailesModel(
//       description: json['description'] as String,
//       notes: json['notes'] as String,
//       imagesPath: List<String>.from(json['imagesPath'] as List),
//     );
//   }

//   // Method to convert a StepsDetailesModel to a JSON map
//   Map<String, dynamic> toJson() {
//     return {
//       'description': description,
//       'imagesPath': imagesPath,
//       'notes': notes,
//     };
//   }
// }
