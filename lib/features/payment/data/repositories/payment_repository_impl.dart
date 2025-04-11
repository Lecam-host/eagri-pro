import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/http/network_info.dart';
import '../../../../core/models/error_handler.dart';
import '../../../../core/models/http_response_model.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/repositories/payment_repository.dart';
import '../../domain/usecases/payment_usecase.dart';
import '../datasources/payment_data_source.dart';
import '../models/payment_model.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PaymentRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> getListMethodPayment(
      int params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getListMethodPayment(params);
        if (response.statusCode == 200) {
          List<PaymentMethodEntity> listMethodPayment = response.data
              .map((e) => PaymentMethodEntity.fromPaymentModel(e))
              .toList();
          return Right((listMethodPayment));
        } else {
          return Left(
            ServerFailure(
              errorMessage: response.statusMessage,
              code: response.statusCode,
            ),
          );
        }
      } catch (error) {
        if (error is DioException) {
          return const Left(
              ServerFailure(errorMessage: ResponseMessage.defaultResponse));
        } else {
          return const Left(
              ServerFailure(errorMessage: ResponseMessage.defaultResponse));
        }
      }
    } else {
      return const Left(
          ServerFailure(errorMessage: ResponseMessage.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, CreatePaymentResponse>> createPayment(
      PaymentParams paymentParams) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.createPayment(paymentParams);
        if (response.statusCode == 201) {
          // List<PaymentMethodEntity> listMethodPayment = response.data
          //     .map((e) => PaymentMethodEntity.fromPaymentModel(e))
          //     .toList();
          return Right((response));
        } else {
          return Left(
            ServerFailure(
              errorMessage: response.statusMessage,
              code: response.statusCode,
            ),
          );
        }
      } catch (error) {
        if (error is DioException) {
          return const Left(
              ServerFailure(errorMessage: ResponseMessage.defaultResponse));
        } else {
          return const Left(
              ServerFailure(errorMessage: ResponseMessage.defaultResponse));
        }
      }
    } else {
      return const Left(
          ServerFailure(errorMessage: ResponseMessage.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, VerifyPaymentResponse>> verifyPayment(
      String signature) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.verifyPayment(signature);
        if (response.statusCode == 200) {
          // List<PaymentMethodEntity> listMethodPayment = response.data
          //     .map((e) => PaymentMethodEntity.fromPaymentModel(e))
          //     .toList();
          return Right((response));
        } else {
          return Left(
            ServerFailure(
              errorMessage: response.statusMessage,
              code: response.statusCode,
            ),
          );
        }
      } catch (error) {
        if (error is DioException) {
          return const Left(
              ServerFailure(errorMessage: ResponseMessage.defaultResponse));
        } else {
          return const Left(
              ServerFailure(errorMessage: ResponseMessage.defaultResponse));
        }
      }
    } else {
      return const Left(
          ServerFailure(errorMessage: ResponseMessage.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, ConfirmPaymentWithOtpResponse>> confirmPaymentWithOtp(
      String signature, String codeOt) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.confirmPaymentWithOtp(signature, codeOt);
        if (response.statusCode == 200) {
          // List<PaymentMethodEntity> listMethodPayment = response.data
          //     .map((e) => PaymentMethodEntity.fromPaymentModel(e))
          //     .toList();
          return Right((response));
        } else {
          return Left(
            ServerFailure(
              errorMessage: response.statusMessage,
              code: response.statusCode,
            ),
          );
        }
      } catch (error) {
        if (error is DioException) {
          return const Left(
              ServerFailure(errorMessage: ResponseMessage.defaultResponse));
        } else {
          return const Left(
              ServerFailure(errorMessage: ResponseMessage.defaultResponse));
        }
      }
    } else {
      return const Left(
          ServerFailure(errorMessage: ResponseMessage.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, List<OptionPayementModel>>>
      getListOptionPayment() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getListOptionPayment();
        if (response.statusCode == 200) {
          // List<PaymentMethodEntity> listMethodPayment = response.data
          //     .map((e) => PaymentMethodEntity.fromPaymentModel(e))
          //     .toList();
          return Right((response.data));
        } else {
          return Left(
            ServerFailure(
              errorMessage: response.statusMessage,
              code: response.statusCode,
            ),
          );
        }
      } catch (error) {
        if (error is DioException) {
          return const Left(
              ServerFailure(errorMessage: ResponseMessage.defaultResponse));
        } else {
          return const Left(
              ServerFailure(errorMessage: ResponseMessage.defaultResponse));
        }
      }
    } else {
      return const Left(
          ServerFailure(errorMessage: ResponseMessage.noInternetConnection));
    }
  }

  @override
  Future<Either<Failure, String>> getCommandeFacture(int elementId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getCommandeFacture(elementId);
        return Right((response));
      } catch (error) {
        if (error is DioException) {
          return const Left(
              ServerFailure(errorMessage: ResponseMessage.defaultResponse));
        } else {
          return const Left(
              ServerFailure(errorMessage: ResponseMessage.defaultResponse));
        }
      }
    } else {
      return const Left(
          ServerFailure(errorMessage: ResponseMessage.noInternetConnection));
    }
  }

  // @override
  // Future<Either<Failure, HttpResponseModel>> getKitCompositeDeliveryPlace(
  //     int supplierId, int page, int limit) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final response = await remoteDataSource.getKitCompositeDeliveryPlace(
  //           supplierId, page, limit);
  //       return Right((response));
  //     } catch (error) {
  //       if (error is DioException) {
  //         return const Left(
  //             ServerFailure(errorMessage: ResponseMessage.defaultResponse));
  //       } else {
  //         return const Left(
  //             ServerFailure(errorMessage: ResponseMessage.defaultResponse));
  //       }
  //     }
  //   } else {
  //     return const Left(
  //         ServerFailure(errorMessage: ResponseMessage.noInternetConnection));
  //   }
  // }
}
