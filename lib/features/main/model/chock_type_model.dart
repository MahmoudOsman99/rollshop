import 'dart:convert';

class ChockTypesModel {
  final String name;
  final String positionInThe;
  final String assemblyRules;
  final String imagePath;

  ChockTypesModel(
      {required this.name,
      required this.imagePath,
      required this.positionInThe,
      required this.assemblyRules});

  factory ChockTypesModel.fromJson(Map<String, dynamic> json) {
    return ChockTypesModel(
      name: json['name'] as String,
      imagePath: json['imagePath'] as String,
      positionInThe: json['positionInThe'] as String,
      assemblyRules: json['assemblyRules'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imagePath': imagePath,
      'assemblyRules': assemblyRules,
      'positionInThe': positionInThe,
    };
  }
}

Future<void> _loadChockTypes() async {
  // Simulate loading from JSON (you'd usually load from a file or network)
  String jsonString = '''
      [
        {"name": "Top of Stroke", "imagePath": "assets/images/tos.png"},
        {"name": "Bottom of Stroke", "imagePath": "assets/images/bos.png"},
        {"name": "Top Dead Stroke", "imagePath": "assets/images/tds.png"},
        {"name": "Bottom Dead Stroke", "imagePath": "assets/images/bds.png"},
        {"name": "Top Thrust Chock", "imagePath": "assets/images/top_thrust.png"},
        {"name": "Bottom Thrust Chock", "imagePath": "assets/images/bottom_thrust.png"},
        {"name": "Piston", "imagePath": "assets/images/piston.png"}
      ]
    ''';
}
