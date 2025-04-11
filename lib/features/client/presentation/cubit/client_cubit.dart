import 'package:bloc/bloc.dart';
import 'package:eagri_pro/core/utils/enum.dart';
import 'package:eagri_pro/features/client/domain/usecases/search_clients_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/client_model.dart';
import '../../data/models/params/search_client_params.dart';
import '../../data/models/search_criteria_model.dart';

part 'client_state.dart';

class ClientCubit extends Cubit<ClientState> {
  final SearchClientsUsecase searchClientsUsecase;
  ClientCubit({required this.searchClientsUsecase}) : super(ClientInitial());

  Future<void> searchClients(String phone) async {
    emit(state.copyWith(status: Status.loading));
    final result = await searchClientsUsecase(
        SearchCriteriaListParams(searchCriteriaList: [
      SearchCriteria(filterKey: "phone", value: phone, operation: "cn"),
    ], dataOption: "all"));
    result.fold(
      (failure) => emit(
          state.copyWith(status: Status.error, message: failure.errorMessage)),
      (clients) => emit(state.copyWith(
          clients: clients, status: Status.success, message: '')),
    );
  }

  Future<void> selectClient(ClientModel client) async {
    emit(state.copyWith(clientSelected: client));
  }
}
