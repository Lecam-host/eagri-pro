import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:eagri_pro/core/interfaces/user_interface.dart';
import 'package:eagri_pro/core/models/http_response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:eagri_pro/core/services/shared_preferences_service.dart';
import 'package:eagri_pro/features/profile/model/user_model.dart';

import '../../../core/http/http_helper.dart';
import '../../../core/http/network_info.dart';

class UserService extends UserInterface {
  final String _baseUrl = dotenv.env['BASE_URL'] ?? "";
  final HttpHelper httpHelper;

  UserService(this.httpHelper, this.networkInfo);
  final NetworkInfo networkInfo;
  @override
  Future<HttpResponseModel> login(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      var url = '$_baseUrl/signin';
      var response = await httpHelper.post(
        url,
        data: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      try {
        if (response.statusCode == 200) {
          return HttpResponseModel(
            statusCode: response.statusCode,
            data: response.data["data"],
            message: response.data["message"],
          );
        } else {
          return HttpResponseModel(
            statusCode: response.statusCode,
            message: response.data["message"],
          );
        }
      } catch (e) {
        return HttpResponseModel(
          statusCode: ErrorHandler.handle(e).failure.code,
          message: ErrorHandler.handle(e).failure.message,
        );
      }
    } else {
      return HttpResponseModel(
        message: DataSource.noInternetConnection.getFailure().message,
      );
    }
  }

  @override
  Future<HttpResponseModel> create(
      {required String email, required String password}) async {
    try {
      var url = Uri.parse('$_baseUrl/users');
      var response = await http.post(
        url,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<HttpResponseModel> delete({required String id}) async {
    try {
      var url = Uri.parse('$_baseUrl/users/$id');
      var response = await http.delete(url);

      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<HttpResponseModel> getById({required String id}) async {
    try {
      var url = Uri.parse('$_baseUrl/users/$id');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<HttpResponseModel> update({required UserModel userModel}) async {
    try {
      var url = Uri.parse('$_baseUrl/users/${userModel.id}');
      var response = await http.put(
        url,
        body: jsonEncode({
          'first_name': userModel.firstName,
          'last_name': userModel.lastName,
          'profile_photo': userModel.profilePhoto,
          'date_of_birth': userModel.dateOfBirth.toUtc().toIso8601String(),
          'gender': userModel.gender,
        }),
      );

      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<HttpResponseModel> validate({required String token}) async {
    try {
      var url = Uri.parse('$_baseUrl/validate');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  Future<void> saveAuthTokenToSP(String authToken) async {
    await SharedPreferencesService.instance
        .setData(PreferenceKey.authToken, authToken);
  }

  Future<String?> getAuthTokenFromSP() async {
    return SharedPreferencesService.instance.getData(PreferenceKey.authToken);
  }

  Future<void> deleteAuthTokenFromSP() async {
    await SharedPreferencesService.instance.removeData(PreferenceKey.authToken);
  }

  @override
  Future<HttpResponseModel> check({required String email}) async {
    try {
      var url = Uri.parse('$_baseUrl/users/check/$email');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<HttpResponseModel> updatePassword(
      {required String userId, required String password}) async {
    try {
      var url = Uri.parse('$_baseUrl/users/$userId');
      var response = await http.put(
        url,
        body: jsonEncode({
          'password': password,
        }),
      );

      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body)["data"],
        message: jsonDecode(response.body)["message"],
      );
    } catch (e) {
      return HttpResponseModel(
        message: 'An error occurred: $e',
      );
    }
  }

  @override
  Future<Either<HttpResponseModel, UserModel>> getUserInfoByToken(
      {required String token}) async {
    if (await networkInfo.isConnected) {
      var url = '$_baseUrl/user-info';
      var response = await httpHelper.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      try {
        if (response.statusCode == 200) {
          return right(UserModel.fromJson(response.data));
        } else {
          return left(HttpResponseModel(
            statusCode: response.statusCode,
            message: response.data["message"],
          ));
        }
      } catch (e) {
        return left(HttpResponseModel(
          statusCode: response.statusCode,
          data: response.data,
          message: response.data["message"],
        ));
      }
    } else {
      return left(HttpResponseModel(
        message: DataSource.noInternetConnection.getFailure().message,
      ));
    }
  }
}
