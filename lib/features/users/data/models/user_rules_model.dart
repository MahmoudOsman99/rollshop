import 'package:rollshop/features/users/data/models/user_model.dart';

class UserRulesModel {
  final UserType userType;
  final bool canAdd;
  final bool canShow;
  final bool canUpdate;
  final bool canDelete;

  UserRulesModel({
    required this.userType,
    required this.canAdd,
    required this.canShow,
    required this.canUpdate,
    required this.canDelete,
  });

  factory UserRulesModel.fromJson(Map<String, dynamic> json) {
    return UserRulesModel(
      userType: json["userType"],
      canAdd: json["canAdd"],
      canShow: json["canShow"],
      canUpdate: json["canUpdate"],
      canDelete: json["canDelete"],
    );
  }
}
