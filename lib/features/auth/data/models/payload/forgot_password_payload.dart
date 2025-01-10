class ForgotPasswordPayload {
  final String phone;

  ForgotPasswordPayload({required this.phone});

  Map<String, dynamic> toJson() => {
        "phone": phone,
      };
}
