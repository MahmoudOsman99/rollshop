class AssemblyStepModel {
  String? id;
  String description;
  String notes;
  String imagePath;
  // Map<String, dynamic> _data;
  // List<StepsDetailesModel> stepsDetailes;

  AssemblyStepModel({
    this.id,
    required this.description,
    required this.imagePath,
    required this.notes,

    // required this.stepsDetailes,
  });
  //  : _data = {
  //         "description": description,
  //         "notes": notes,
  //       };

  // dynamic operator [](String key) => _data[key];

  // Factory constructor to create a StepsDetailesModel from a JSON map
  factory AssemblyStepModel.fromJson(
      {required Map<String, dynamic> json, idFromFirebase}) {
    return AssemblyStepModel(
      id: idFromFirebase ?? json['id'],
      description: json['description'] ?? "",
      notes: json['notes'] ?? "",
      imagePath: json['imagePath'],
    );
  }

  // Method to convert a StepsDetailesModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'imagePath': imagePath,
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
