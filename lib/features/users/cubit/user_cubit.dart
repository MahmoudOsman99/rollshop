import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollshop/core/helpers/image_handler.dart';
import 'package:rollshop/features/users/cubit/user_state.dart';
import 'package:rollshop/features/users/data/models/user_model.dart';
import 'package:rollshop/features/users/data/repository/user_repository.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.repo}) : super(UserInitialState());
  final UserRepository repo;

  List<UserModel> waitingUsers = [];

  Future<void> getWaitingUsersToApproved() async {
    final getWaitingUsers = await repo.getWaitingUsersToApprove();

    getWaitingUsers.fold((failure) {
      emit(WaitingUsersLoadedFailedState(error: failure.message));
    }, (loadedWaitingUsers) {
      waitingUsers = loadedWaitingUsers;
      emit(WaitingUsersLoadedSuccessState(waitingUsers: loadedWaitingUsers));
    });
  }

  Future<void> setUser({required UserModel user, File? imagePath}) async {
    emit(UserLoadingState());
    String? path;
    if (imagePath != null) {
      path = await ImageHandler().uploadImageToImgur(imagePath);
    }
    final setUserProccess = await repo.setUser(
      user: UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        userType: user.userType,
        phoneNumber: user.phoneNumber,
        isApproved: user.isApproved,
        createdAt: user.createdAt,
        imagePath: path,
        isBanned: user.isBanned,
        isEmailVerified: user.isEmailVerified,
        isPhoneVerified: user.isPhoneVerified,
      ),
    );
    setUserProccess.fold((failure) {
      emit(UserUpdatedErrorState(error: failure.message));
    }, (value) {
      emit(UserUpdatedSuccessState());
    });
  }
}
