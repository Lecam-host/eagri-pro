import 'package:dartz/dartz.dart';

import '../../features/profile/model/user_model.dart';
import '../models/http_response_model.dart';

abstract class UserInterface {
  Future<HttpResponseModel> login(
      {required String email, required String password});

  Future<Either<HttpResponseModel, UserModel>> getUserInfoByToken({
    required String token,
  });
  Future<HttpResponseModel> validate({required String token});
  Future<HttpResponseModel> create(
      {required String email, required String password});
  Future<HttpResponseModel> getById({required String id});
  Future<HttpResponseModel> update({required UserModel userModel});
  Future<HttpResponseModel> updatePassword(
      {required String userId, required String password});
  Future<HttpResponseModel> delete({required String id});
  Future<HttpResponseModel> check({required String email});
}
