import 'dart:developer';
import 'package:eagri_pro/features/auth/domain/entities/user_entity.dart';
import 'package:eagri_pro/features/auth/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../../core/utils/enum.dart';
import '../../../../core/utils/usecase.dart';
import '../../../profile/domain/usescases/get_account_usecase.dart';
import '../../../profile/domain/usescases/get_user_by_id_usecase.dart';
import '../../data/models/user_model.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/usecases/check_auth_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final GetAccountUsecase getAccountUsecase;
  final GetUserByIdUsecase getUserByIdUsecase;
  final CheckAuthUsecase checkAuthUsecase;
  final LogoutUsecase logoutUsecase;
  // final RegistrationTokenUsecase registrationTokenUsecase;
  AuthBloc(
      {required this.loginUsecase,
      required this.checkAuthUsecase,
      // required this.registrationTokenUsecase,
      // required this.logoutUsecase,
      required this.getUserByIdUsecase,
      required this.logoutUsecase,
      required this.getAccountUsecase})
      : super(const LoginInitial()) {
    on<SendRequestLogin>((event, emit) async {
      emit(state.copyWith(stateStatus: Status.loading));
      final result = await loginUsecase.call(
          LoginParams(username: event.username, password: event.password));
      result.fold((failure) {
        emit(state.copyWith(
            stateStatus: Status.error,
            errorMessage: failure.errorMessage,
            status: AuthenticationStatus.unauthenticated));
      }, (user) async {
        if (user.typeAccount != "AGENT_RELAIS") {
          emit(state.copyWith(
              stateStatus: Status.error,
              errorMessage:
                  "Vous n'avez pas le droit d'accéder à cette application",
              status: AuthenticationStatus.unauthenticated));
        }
        emit(state.copyWith(
            stateStatus: Status.success,
            user: user,
            status: AuthenticationStatus.authenticated));
        // add(SendRequestRegistrationTokenEvent(userName: event.username));
        add(GetAccountEvent());
      });
    });
    on<CheckAuthentification>((event, emit) async {
      emit(state.copyWith(stateStatus: Status.loading));
      final result = await checkAuthUsecase.call(NoParams());
      result.fold((failure) {
        emit(state.copyWith(
            stateStatus: Status.error,
            errorMessage: failure.errorMessage,
            status: AuthenticationStatus.unauthenticated));
      }, (user) {
        add(const GetAccountEvent());
        emit(state.copyWith(
            stateStatus: Status.success,
            user: user,
            status: AuthenticationStatus.authenticated));
      });
    });
    on<SendRequestLogout>((event, emit) async {
      emit(state.copyWith(stateStatus: Status.loading));
      // await FirebaseMessaging.instance.requestPermission(provisional: true);
      String? token = "";
      // token = await NotificationUtils().getFirebaseMessagingToken();
      final result = await logoutUsecase.call(LogoutParams(token: token, userName: event.userName));
      result.fold((failure) {
        emit(state.copyWith(
            stateStatus: Status.error,
            errorMessage: failure.errorMessage,
            status: AuthenticationStatus.unauthenticated));
      }, (user) {
        emit(AuthState(status: AuthenticationStatus.unauthenticated));
      });
    });
    on<GetAccountEvent>((event, emit) async {
      try {
        final result = await getAccountUsecase.call(NoParams());
        result.fold((failure) {
          emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
        }, (user) {
          emit(state.copyWith(
              account: user, status: AuthenticationStatus.authenticated));
        });
      } catch (e) {
        emit(state.copyWith(status: AuthenticationStatus.authenticated));
      }
    });
    // on<SendRequestRegistrationTokenEvent>((event, emit) async {
    //   await FirebaseMessaging.instance.requestPermission(provisional: true);
    //   String? token = "";
    //   token = await NotificationUtils().getFirebaseMessagingToken();
    //   log(token);

    //   emit(state.copyWith(stateStatus: Status.loading));
    //   await registrationTokenUsecase.call(
    //       RegistrationTokenParams(token: token, userName: event.userName));
    // });
    on<GetUserByIdEvent>((event, emit) async {
      emit(state.copyWith(stateStatus: Status.loading));
      final result = await getUserByIdUsecase.call(event.id);
      result.fold((failure) {
        emit(state.copyWith(
            stateStatus: Status.error,
            errorMessage: failure.errorMessage,
            //?? "Une erreur est survenue",
            status: AuthenticationStatus.unauthenticated));
      }, (user) {
        emit(state.copyWith(
            stateStatus: Status.success,
            userModel: user,
            status: AuthenticationStatus.authenticated));
      });
    });
    on<ChangeAuthenticationStatusEvent>((event, emit) {
      emit(AuthState(status: event.status));
    });
  }
  @override
  AuthState fromJson(Map<String, dynamic> json) => AuthState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AuthState state) => state.toJson();
}
