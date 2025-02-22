import 'package:equatable/equatable.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';

abstract class PartsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PartsInitialState extends PartsState {}

class PartsLoadingState extends PartsState {}

class PartWatingState extends PartsState {}

class PartAddeddSuccessfullyState extends PartsState {
  final String partName;
  PartAddeddSuccessfullyState({required this.partName});

  @override
  List<Object?> get props => [partName];
}

class PartAddeddFailureState extends PartsState {
  final String error;

  PartAddeddFailureState({required this.error});
}

class PartChangeAllowEditState extends PartsState {
  final bool allowEdit;

  // PartChangeAllowEditState();
  PartChangeAllowEditState({required this.allowEdit});

  @override
  List<Object?> get props => [allowEdit];
}

class PartDeletedSuccessfullyState extends PartsState {}

//Update
class PartUpdatedSuccessfullyState extends PartsState {}

class PartsLoadedSuccessfullyState extends PartsState {
  final List<PartsWithMaterialNumberModel> parts;

  PartsLoadedSuccessfullyState({required this.parts});
}

class PartsErrorState extends PartsState {
  final String error;

  PartsErrorState({required this.error});
}
