import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:eagri_pro/core/error/failure.dart';
import 'package:eagri_pro/features/product/data/models/type_product_model.dart';
import 'package:eagri_pro/packages/models/formulaire_model.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/http/http_helper.dart';
import '../models/params/publish_product_model.dart';
import '../models/params/search_product_article_params.dart';
import '../models/result_product_search_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<TypeProductModel>> getProducts();
  Future<List<DataFormulaireModel>> getFormByProductById(int id);
  Future<List<ResultProductSearchModel>> search(
      SearchProductArticleParams params);
  Future<bool> publishProduct(PublishProductModel data);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final HttpHelper httpHelper;

  ProductRemoteDataSourceImpl({required this.httpHelper});
  @override
  Future<List<TypeProductModel>> getProducts() async {
    try {
      final response = await httpHelper
          .get('${ConstantUrl.msArticle}/products/typeOfferPublication');
      return (response.data["data"] as List)
          .map((e) => TypeProductModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['statusMessage']);
    }
  }

  @override
  Future<List<DataFormulaireModel>> getFormByProductById(int id) async {
    try {
      final response = await httpHelper.post(
          '${ConstantUrl.msArticle}/products/forms',
          data: {"productId": id});
      final result = (response.data["data"] as List)
          .map((e) => DataFormulaireModel.fromJson(e))
          .toList();
      return result;
    } on DioException catch (e) {
      throw Exception(e.response?.data['statusMessage']);
    }
  }

  @override
  Future<List<ResultProductSearchModel>> search(
      SearchProductArticleParams params) async {
    try {
      final response = await httpHelper.get(
          "${ConstantUrl.msArticle}/products/searchProduct",
          queryParameters: params.toJson());
      if (response.statusCode == 200) {
        return (response.data["data"] as List)
            .map((e) => ResultProductSearchModel.fromJson(e))
            .toList();
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> publishProduct(PublishProductModel data) async {
    final dataJson = await data.toJson();
    final dataFormData = FormData.fromMap(dataJson);
    print(dataJson);
    try {
      final response = await httpHelper.post(
          "${ConstantUrl.msCatalogue}/publications/create",
          data: dataFormData);
      if (response.statusCode == 201) {
        return true;
      } else {
        throw ServerFailure(errorMessage: response.data['statusMessage']);
      }
    } on DioException catch (e) {
      inspect(e);
      throw ServerFailure(
          errorMessage: e.response?.data['statusMessage'] ?? e.message);
    }
  }
}
