import '../../data/models/payment_model.dart';

class PaymentMethodEntity {
  int? methodId;
  int? organismId;
  double? rate;
  PaymentOptionModel? paymentMethod;
  String? name;
  String? code;

  PaymentMethodEntity(
      {this.methodId,
      this.organismId,
      this.rate,
      this.paymentMethod,
      this.name,
      this.code});

  factory PaymentMethodEntity.fromPaymentModel(
          PaymentMethodModel paymentMethod) =>
      PaymentMethodEntity(
        name: paymentMethod.name,
        code: paymentMethod.code,
        rate: paymentMethod.rate,
        methodId: paymentMethod.methodId,
        organismId: paymentMethod.organismId,
        paymentMethod: paymentMethod.paymentMethod,
      );
}
