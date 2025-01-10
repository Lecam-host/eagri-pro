import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/http/http_helper.dart';
import '../../../auth/data/models/account_model.dart';
import '../../../auth/data/models/payload/update_profil_payload.dart';
import '../../../auth/data/models/user_model.dart';

abstract class AccountRemoteDataSource {
  Future<UserModel> getAccount();
  Future<AccountModel> updateAccount(UpdateProfilPayload account);
  Future<UserModel> getUserById(int id);
}

class AccountRemoteDataSourceImpl extends AccountRemoteDataSource {
  final HttpHelper httpHelper;
  AccountRemoteDataSourceImpl({required this.httpHelper});

  @override
  Future<UserModel> getAccount() async {
    try {
      final response = await httpHelper.get('/security/auth/get-profile');
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['statusMessage']);
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AccountModel> updateAccount(UpdateProfilPayload account) async {
    final payloadX = await account.toJson();
    try {
      final response = await httpHelper.put(
          '${ConstantUrl.msSecurity}/users/edit/${account.id}',
          data: payloadX);
      if (response.statusCode == 200) {
        return AccountModel.fromJson(response.data['data']['user']);
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel> getUserById(int id) async {
    try {
      final response =
          await httpHelper.get('${ConstantUrl.msSecurity}/users/one/$id');
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['statusMessage']);
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
