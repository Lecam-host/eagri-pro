class ResetPasswordPayload {
  final String token;
  final String password;

  ResetPasswordPayload({required this.token, required this.password});

  Map<String, dynamic> toJson() => {"token": token, "newPassword": password};
}
