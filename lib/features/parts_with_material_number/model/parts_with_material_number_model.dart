class PartsWithMaterialNumberModel {
  String? id;
  String name;
  int materialNumber;
  String type;
  String usage;
  String areaOfUsage;
  String imagePath;
  int? drawingPartNumber;
  String? notes;
  String sizes;

  PartsWithMaterialNumberModel({
    this.id,
    required this.name,
    required this.materialNumber,
    required this.type,
    required this.usage,
    required this.imagePath,
    required this.areaOfUsage,
    this.drawingPartNumber,
    this.notes,
    required this.sizes,
  });

  factory PartsWithMaterialNumberModel.fromJson(
      {required Map<String, dynamic> json, String? idFromFirebase}) {
    return PartsWithMaterialNumberModel(
      id: idFromFirebase ?? json["id"],
      name: json["name"] ?? "",
      type: json["type"] ?? "",
      imagePath: json["imagePath"] ?? "",
      materialNumber: json["materialNumber"] ?? 0,
      usage: json["usage"] ?? "",
      areaOfUsage: json["areaOfUsage"] ?? "",
      drawingPartNumber: json["drawingPartNumber"] ?? 0,
      sizes: json["sizes"] ?? "",
      notes: json["notes"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "type": type,
      "imagePath": imagePath,
      "materialNumber": materialNumber,
      "usage": usage,
      "areaOfUsage": areaOfUsage,
      "drawingPartNumber": drawingPartNumber,
      "sizes": sizes,
      "notes": notes,
    };
  }
}
