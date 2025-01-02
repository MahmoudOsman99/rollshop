import 'package:equatable/equatable.dart';
import 'package:rollshop/features/assembly_steps_feature/models/chock_type_model.dart';

abstract class ChocksState extends Equatable {
  const ChocksState();

  @override
  List<Object> get props => [];
}

class ChocksInitial extends ChocksState {}

class ChocksLoadingState extends ChocksState {}

class ChockAddedSuccessfullyState extends ChocksState {}

class ChocksLoadedState extends ChocksState {
  final List<ChockTypesModel> chocks;

  const ChocksLoadedState({
    required this.chocks,
  });
}
