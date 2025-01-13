import 'package:equatable/equatable.dart';
import 'package:rollshop/features/chock_feature/models/chock_type_model.dart';

abstract class ChockState extends Equatable {
  const ChockState();

  @override
  List<Object> get props => [];
}

class ChocksInitialState extends ChockState {}

class ChocksLoadingState extends ChockState {}

class ChocksLoadedFailedState extends ChockState {
  final String error;
  const ChocksLoadedFailedState({
    required this.error,
  });
}

class ChockAddedSuccessfullyState extends ChockState {}

class ChocksLoadedSuccessfullyState extends ChockState {
  final List<ChockTypesModel> chocks;

  const ChocksLoadedSuccessfullyState({
    required this.chocks,
  });
}

class ChockAddFieldsAddedState extends ChockState {}

class ChockAddFieldsRemovedState extends ChockState {}

class ChockImageChangedState extends ChockState {}
