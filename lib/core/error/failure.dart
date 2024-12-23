import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int code;
  final String errorMessage;
  const Failure({required this.errorMessage, this.code = 400});

  @override
  List<Object?> get props => [errorMessage, code];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.errorMessage, super.code});

  @override
  List<Object> get props => [errorMessage, code];
}

class CacheFailure extends Failure {
  const CacheFailure({required super.errorMessage, super.code});

  @override
  List<Object> get props => [errorMessage, code];
}

class ApiFailure {
  int code;
  String message;

  ApiFailure(this.code, this.message);
}

class CallApiStatusModel<T> {
  int? code;
  String? message;
  CallApiStatusEnum statut;
  T? data;
  CallApiStatusModel({
    this.code,
    this.message,
    this.statut = CallApiStatusEnum.loading,
    this.data,
  });
  CallApiStatusModel<T> dispose() {
    return CallApiStatusModel<T>();
  }
}

enum CallApiStatusEnum {
  success,
  error,
  loading,
}
