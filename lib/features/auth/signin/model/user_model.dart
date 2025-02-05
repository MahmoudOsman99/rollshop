import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final UserType userType; // Example: "admin", "user", "guest"
  final String? imagePath; // Optional: Image path

  const UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.userType,
    required this.phoneNumber,
    this.imagePath,
  });

  @override
  List<Object?> get props =>
      [id, name, email, password, userType, phoneNumber, imagePath];

  factory UserModel.fromJson(Map<String, dynamic> json,
      {required idFromFirebase}) {
    return UserModel(
      id: idFromFirebase ?? json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      userType: json["userType"] != null
          ? UserType.values.firstWhere(json['userType'])
          : UserType.technician,
      // json['userType'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      imagePath: json['imagePath'], // Handle potential null value
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'userType': UserType.values.indexOf(userType),
      'phoneNumber': phoneNumber,
      'imagePath': imagePath,
    };
  }
}

enum UserType {
  admin,
  engineer,
  foreman,
  technician,
  user,
}
