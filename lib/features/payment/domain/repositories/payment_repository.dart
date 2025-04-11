import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/http_response_model.dart';
import '../../data/models/payment_model.dart';
import '../entities/payment_entity.dart';
import '../usecases/payment_usecase.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentMethodEntity>>> getListMethodPayment(
      int topOrganismeId);
  Future<Either<Failure, List<OptionPayementModel>>> getListOptionPayment();

  Future<Either<Failure, CreatePaymentResponse>> createPayment(
    PaymentParams paymentParams,
  );

  Future<Either<Failure, VerifyPaymentResponse>> verifyPayment(
    String signature,
  );
  Future<Either<Failure, ConfirmPaymentWithOtpResponse>> confirmPaymentWithOtp(
      String signature, String codeOt);

  Future<Either<Failure, String>> getCommandeFacture(int elementId);
  // Future<Either<Failure, HttpResponseModel>> getKitCompositeDeliveryPlace(
  //     int supplierId, int page, int limit);
}
