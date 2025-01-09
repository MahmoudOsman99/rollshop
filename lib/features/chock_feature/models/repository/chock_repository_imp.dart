import 'package:rollshop/features/chock_feature/models/chock_type_model.dart';
import 'package:rollshop/features/chock_feature/models/data/remote/remote_data_source.dart';
import 'package:rollshop/features/chock_feature/models/repository/chock_repository.dart';

class ChockRepositoryImp implements ChockRepository {
  ChockRepositoryImp({required this.remote});
  ChockRemoteDataSource remote;
  @override
  Future<List<ChockTypesModel>> getAllChocks() async {
    return await remote.getAllChocks();
  }
}
