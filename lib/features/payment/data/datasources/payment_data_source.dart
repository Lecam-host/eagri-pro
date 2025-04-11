import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/http/http_helper.dart';
import '../../../../core/models/http_response_model.dart';
import '../../domain/usecases/payment_usecase.dart';
import '../models/payment_model.dart';

abstract class PaymentRemoteDataSource {
  Future<GetListPaymentMethodResponse> getListMethodPayment(
    int topParentId,
  );
  Future<CreatePaymentResponse> createPayment(
    PaymentParams paymentParams,
  );

  Future<VerifyPaymentResponse> verifyPayment(
    String signature,
  );

  Future<ConfirmPaymentWithOtpResponse> confirmPaymentWithOtp(
      String signature, String codeOtp);

  Future<ListOptionPaymentResponse> getListOptionPayment();
  Future<String> getCommandeFacture(int elementId);
  // Future<HttpResponseModel> getKitCompositeDeliveryPlace(
  //     int supplierId, int page, int limit);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final HttpHelper httpHelper;
  PaymentRemoteDataSourceImpl({required this.httpHelper});
  @override
  Future<GetListPaymentMethodResponse> getListMethodPayment(
      int topParentId) async {
    try {
      final response = await httpHelper.get(
        "${ConstantUrl.msConfig}/payment-method/all?organismId=$topParentId",
        //queryParameters: {"organismId": topParentId},
      );
      if (response.data['statusCode'] == 200) {
        return GetListPaymentMethodResponse.fromJson(response.data);
      } else {
        throw Exception(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> getCommandeFacture(int elementId) async {
    try {
      final response = await httpHelper.get(
        "${ConstantUrl.msPayment}/transaction/invoice?elementId=$elementId",
        //queryParameters: {"organismId": topParentId},
      );
      if (response.data['statusCode'] == 200) {
        return response.data['data'];
      } else {
        throw Exception(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<CreatePaymentResponse> createPayment(
    PaymentParams paymentParams,
  ) async {
    try {
      String url = "${ConstantUrl.msPayment}/transaction/create";
      var response = await httpHelper.post(
        url,
        data: paymentParams.toJson(),
      );
      if (response.data['statusCode'] == 201) {
        return CreatePaymentResponse.fromJson(response.data);
      } else {
        throw Exception(response.data);
      }
    } catch (e) {
      if (e is DioException) {
        return CreatePaymentResponse.fromJson(e.response!.data);
      } else {
        throw Exception(e);
      }
    }
  }

  @override
  Future<VerifyPaymentResponse> verifyPayment(String signature) async {
    try {
      Map<String, dynamic> data = {
        "transactionId": signature,
      };
      String url = "${ConstantUrl.msPayment}/transaction/verify";
      var response = await httpHelper.get(
        url,
        queryParameters: data,
      );

      if (response.data['statusCode'] == 200) {
        return VerifyPaymentResponse.fromJson(response.data);
      } else {
        throw Exception(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ConfirmPaymentWithOtpResponse> confirmPaymentWithOtp(
      String signature, String codeOtp) async {
    try {
      Map<String, dynamic> data = {"signature": signature, "codeOtp": codeOtp};
      String url = "${ConstantUrl.msPayment}/transaction/origination";
      var response = await httpHelper.get(
        url,
        queryParameters: data,
      );

      if (response.data['statusCode'] == 200) {
        return ConfirmPaymentWithOtpResponse.fromJson(response.data);
      } else {
        throw Exception(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ListOptionPaymentResponse> getListOptionPayment() async {
    try {
      String url = "${ConstantUrl.msPayment}/transaction/origination";
      var response = await httpHelper.get(
        url,
      );

      if (response.data['statusCode'] == 200) {
        return ListOptionPaymentResponse.fromJson(response.data);
      } else {
        throw Exception(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // @override
  // Future<HttpResponseModel> getKitCompositeDeliveryPlace(
  //     int supplierId, int page, int limit) async {
  //   try {
  //     String url =
  //         "${ConstantUrl.msDeveryComposite}/locations/supplier/$supplierId";
  //     var response = await httpHelper.get(url, queryParameters: {
  //       "page": page,
  //       "limit": limit,
  //     });
  //     if (response.data['statusCode'] == 200) {
  //       return HttpResponseModel.fromJson(response.data);
  //     } else {
  //       throw Exception(response.data);
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}
