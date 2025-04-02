part of 'client_cubit.dart';

class ClientState extends Equatable {
  final List<ClientModel> clients;
  final Status status;
  final ClientModel? clientSelected;
  final String? message;
  const ClientState({
    this.clients = const [],
    this.status = Status.initial,
    this.clientSelected,
    this.message,
  });

  ClientState copyWith({
    List<ClientModel>? clients,
    Status? status,
    ClientModel? clientSelected,
    String? message,
  }) {
    return ClientState(
      clients: clients ?? this.clients,
      status: status ?? this.status,
      clientSelected: clientSelected ?? this.clientSelected,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        clients,
        status,
        clientSelected,
        message
  ];
}

final class ClientInitial extends ClientState {}
