import 'package:equatable/equatable.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';

abstract class PartsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PartsInitialState extends PartsState {}

class PartsLoadingState extends PartsState {}

class PartWatingState extends PartsState {}

class PartAddeddSuccessfullyState extends PartsState {}

class PartAddeddFailureState extends PartsState {
  final String error;

  PartAddeddFailureState({required this.error});
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
