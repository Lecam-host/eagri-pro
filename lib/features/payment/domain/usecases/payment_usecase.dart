import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/models/http_response_model.dart';
import '../../data/models/payment_model.dart';
import '../entities/payment_entity.dart';
import '../repositories/payment_repository.dart';

class PaymentUsecase {
  final PaymentRepository repository;

  PaymentUsecase({required this.repository});

  Future<Either<Failure, List<PaymentMethodEntity>>> getListMethodPayment(
      int params) async {
    return repository.getListMethodPayment(params);
  }

  Future<Either<Failure, List<OptionPayementModel>>>
      getListOptionPayment() async {
    return repository.getListOptionPayment();
  }

  Future<Either<Failure, CreatePaymentResponse>> createPayment(
    PaymentParams paymentParams,
  ) async {
    return repository.createPayment(paymentParams);
  }

  Future<Either<Failure, VerifyPaymentResponse>> verifyPayment(
    String signature,
  ) async {
    return repository.verifyPayment(signature);
  }

  Future<Either<Failure, ConfirmPaymentWithOtpResponse>> confirmPaymentWithOtp(
      String signature, String codeOt) async {
    return repository.confirmPaymentWithOtp(signature, codeOt);
  }

  Future<Either<Failure, String>> getCommandefacture(
    int elementId,
  ) async {
    return repository.getCommandeFacture(elementId);
  }

  // Future<Either<Failure, HttpResponseModel>> getKitCompositeDeliveryPlace(
  //     int supplierId, int page, int limit) async {
  //   return repository.getKitCompositeDeliveryPlace(supplierId, page, limit);
  // }
}

// class DeleteItemToCartParams {
//   final int shoppingCartId;
//   List<int> itemIds;
//   DeleteItemToCartParams({
//     required this.shoppingCartId,
//     required this.itemIds,
//   });

//   Map<String, dynamic> toJson() => {
//         'shoppingCartId': shoppingCartId,
//         "itemIds": itemIds.map((x) => x).toList(),
//       };
// }
class PaymentParams {
  PaymentParams({
    this.typeTransaction = "ORDER",
    this.phoneNumber,
    required this.elementId,
    this.codeOtp,
    required this.paymentOptionId,
    this.cardCvv,
    this.cardNumber,
    this.customerFirstName,
    this.customerLastName,
    this.cardExpirationMonth,
    this.cardExpirationYear,
  });
  String typeTransaction;
  String? phoneNumber;
  int elementId;
  int paymentOptionId;
  String? codeOtp;
  String? cardCvv;
  String? cardNumber;
  String? customerFirstName;
  String? customerLastName;
  String? cardExpirationMonth;
  String? cardExpirationYear;
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "typeTransaction": typeTransaction,
      "phoneNumber": phoneNumber,
      "elementId": elementId,
      "paymentOptionId": paymentOptionId,
      "codeOtp": codeOtp,
      "cardCvv": cardCvv,
      "cardNumber": cardNumber,
      "customerFirstName": customerFirstName,
      "customerLastName": customerLastName,
      "cardExpirationMonth": cardExpirationMonth,
      "cardExpirationYear": cardExpirationYear
    };

    map.removeWhere((key, value) => value == null);
    return map;
  }
}
