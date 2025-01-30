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

class ChocksAssemblyStepsUploadedSuccessfullyState extends ChockState {
  final List<String> imagesUrls;

  const ChocksAssemblyStepsUploadedSuccessfullyState({
    required this.imagesUrls,
  });
}

class ChockAddFieldsAddedState extends ChockState {}

class ChockViewStepsState extends ChockState {
  bool isView;
  ChockViewStepsState({required this.isView});
  @override
  List<Object> get props => [isView];
}

class ChockViewPartsState extends ChockState {
  bool isView;
  ChockViewPartsState({required this.isView});
  @override
  List<Object> get props => [isView];
}

class ChockAddFieldsRemovedState extends ChockState {}

class ChockImageChangedState extends ChockState {}
