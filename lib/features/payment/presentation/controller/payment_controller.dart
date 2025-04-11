import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../../../core/utils/enum.dart';
import '../../../../injection_container.dart';
import '../../../auth/bloc/login/auth_bloc.dart';
import '../../data/models/payment_model.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/usecases/payment_usecase.dart';

class PaymentController extends GetxController {
  var isLoadPaymentMethod = false.obs;
  var isLoadPaymentOption = false.obs;
  var listPaymentMethod = <PaymentMethodEntity>[].obs;
  final paymentMethods = <MultiSelectItem>[].obs;
  final paymentOptions = <PaymentOptionModel>[].obs;
  PaymentUsecase paymentUsecase = PaymentUsecase(repository: di());

  var optionsPaiment = <OptionPayementModel>[].obs;

  var isPayObserve = false.obs;
  PaymentNotificationStatus? parsePaymentNotifStatuse(String? value) {
    if (value == null) return null;
    // Future.delayed(Duration(seconds: 5)).then((_) {
    //   paiementController.verifyPaiment(
    //     context: context,
    //     cart: widget.waitingConfirmationPaymentViewArgs.cart,
    //     optionPaiement:
    //         widget.waitingConfirmationPaymentViewArgs.optionPaiement,
    //   );
    // });
    print('Parsing value: $value'); // Log pour déboguer
    try {
      final status = PaymentNotificationStatus.values.firstWhere(
        (e) {
          print(e.name);
          print(value);
          print(e.name.length);
          print(value.length);
          try {
            return e.name.toUpperCase() == value.trim().toUpperCase();
          } catch (e) {
            inspect(e);
            return false;
          }
        },
        orElse: () => PaymentNotificationStatus.OTHER,
      );
      print('Parsed status: $status'); // Log pour déboguer
      return status;
    } catch (e) {
      print('Error parsing status: $e'); // Log pour déboguer
      return PaymentNotificationStatus.OTHER;
    }
  }

  getListPaymentMethod(BuildContext context) async {
    isLoadPaymentMethod.value = true;
    listPaymentMethod.value = [];
    final result = context.read<AuthBloc>().state.user?.organismTopParentId;
    //final result = context.read<AccountCubit>().state.auth;
    if (result != null) {
      await paymentUsecase.getListMethodPayment(result).then(
        (value) {
          value.fold((failure) {
            isLoadPaymentMethod.value = false;
          }, (data) {
            listPaymentMethod.value = data;
            paymentOptions.value = [];
            if (data.isNotEmpty) {
              for (final paymentMethod in data) {
                final paymentOptionsList =
                    paymentMethod.paymentMethod?.paymentOptions;

                if (paymentOptionsList != null &&
                    paymentOptionsList.isNotEmpty) {
                  paymentOptions.addAll(paymentOptionsList);
                }
              }
            }

            isLoadPaymentMethod.value = false;
            paymentMethods.value = [];
          });
        },
      );
    }
  }

  getListOptionPayement() async {
    isLoadPaymentOption.value = true;
    listPaymentMethod.value = [];
    await paymentUsecase.getListOptionPayment().then(
      (value) {
        value.fold((failure) {
          isLoadPaymentOption.value = false;
        }, (data) {
          optionsPaiment.value = data;
          isLoadPaymentOption.value = false;
          paymentMethods.value = listPaymentMethod
              .map((e) => MultiSelectItem(
                    e.methodId,
                    e.name!,
                  ))
              .toList();
        });
      },
    );
  }

}
