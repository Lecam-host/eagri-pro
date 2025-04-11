enum Status {
  initial,
  loading,
  success,
  error
}

enum Reseau {
  orange,
  moov,
  mtn,
}

enum OptionPaiement {
  orange,
  moov,
  mtn,
  wave,
  carteCredit,
  cash,
  invalid,
}

enum PaymentStatus {
  PAYMENT_FAILED,
  SUCCESS,
  WAITING_CUSTOMER_TO_VALIDATE,
  OTHER
}

enum PaymentNotificationStatus { SUCCEEDED, CANCELLED, PROCESSING, OTHER }
