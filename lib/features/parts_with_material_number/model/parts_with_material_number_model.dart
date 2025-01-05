class PartsWithMaterialNumberModel {
  String? id;
  String name;
  int materialNumber;
  String type;
  String usage;
  String areaOfUsage;
  String imagePath;
  String sizes;

  PartsWithMaterialNumberModel({
    this.id,
    required this.name,
    required this.materialNumber,
    required this.type,
    required this.usage,
    required this.imagePath,
    required this.areaOfUsage,
    required this.sizes,
  });

  factory PartsWithMaterialNumberModel.fromJson(
      {required Map<String, dynamic> json, String? idFromFirebase}) {
    return PartsWithMaterialNumberModel(
      id: idFromFirebase ?? json["id"],
      name: json["name"],
      type: json["type"],
      imagePath: json["imagePath"],
      materialNumber: json["materialNumber"],
      usage: json["usage"],
      areaOfUsage: json["areaOfUsage"],
      sizes: json["sizes"],
    );
  }
}
