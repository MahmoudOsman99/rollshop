import 'package:flutter_bloc/flutter_bloc.dart';
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

  // Future<bool> isUserApprovedToSignin({required String email}) async {
  // final isApprovedProccess = await repo.isUserApprovedToSignin(email: email);

  // if (isApprovedProccess) {
  //   return true;
  // } else {
  //   return false;
  // }
  // bool isApproved = false;
  // isApprovedProccess.fold((failure) {
  //   // return false;
  //   // emit(IsUserApprovedToSignInState(isApproved: false));
  //   return isApproved = false;
  // }, (isApproved) {
  //   return isApproved = true;
  // });
  // emit(IsUserApprovedToSignInState(isApproved: isApproved));
  // return false;
  // }
}
