import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/http_response_model.dart';
import '../../../profile/model/user_model.dart';
import '../../../profile/service/user_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserService userService;

  LoginBloc({required this.userService}) : super(const LoginState()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(const LoginState(isLoading: true));
      try {
        HttpResponseModel<dynamic> loginResponse = await userService.login(
            email: event.email, password: event.password);
        if (loginResponse.data != null) {
          UserTokensModel userTokensModel = UserTokensModel.fromMap(
            loginResponse.data,
          );
          await userService
              .getUserInfoByToken(token: userTokensModel.accessToken)
              .then((value) => value.fold((l) {
                    emit(LoginFailed(
                        message: l.message,
                        isLoading: false,
                        statusCode: l.statusCode));
                  }, (r) {
                    emit(LoginSuccess(
                        user: r,
                        //   message: r.message,
                        isLoading: false));
                  }));
        } else {
          emit(LoginFailed(
              message: loginResponse.message,
              isLoading: false,
              statusCode: loginResponse.statusCode));
        }
      } catch (error) {
        emit(LoginFailed(
            message: error.toString(), isLoading: false, statusCode: 404));
      }
    });

    on<ValidateAuthToken>((event, emit) async {
      emit(const LoginState(isLoading: true));
      try {
        HttpResponseModel<dynamic> validateResponse =
            await userService.validate(token: event.authToken);
        if (validateResponse.statusCode == 200) {
          final user = UserModel.fromMap(validateResponse.data);
          emit(
            ValidateSuccess(
                user: user,
                statusCode: validateResponse.statusCode,
                message: validateResponse.message,
                isLoading: false),
          );
        } else {
          emit(
            ValidateFailed(
              message: validateResponse.message,
              statusCode: validateResponse.statusCode,
              isLoading: false,
            ),
          );
        }
      } catch (error) {
        await userService.deleteAuthTokenFromSP();
        emit(ValidateFailed(message: error.toString(), isLoading: false));
      }
    });

    on<LogoutButtonPressed>((event, emit) async {
      await userService.deleteAuthTokenFromSP();
      emit(const LoginState(isLoading: false, message: null));
    });

    on<UpdatePasswordButtonPressed>((event, emit) async {
      emit(const LoginState(isLoading: true));
      try {
        HttpResponseModel<dynamic> updateResponse = await userService
            .updatePassword(userId: event.userId, password: event.password);
        if (updateResponse.statusCode == 200) {
          // await FirebaseService.sendMail(
          //     toMail: event.email,
          //     subject: LocaleKeys.transaction_successful_subject.tr(),
          //     text: LocaleKeys.password_update_successful_text.tr());
          emit(UpdatePasswordSuccess(
              message: updateResponse.message, isLoading: false));
        } else {
          emit(UpdatePasswordFailed(
              message: updateResponse.message, isLoading: false));
        }
      } catch (error) {
        emit(UpdatePasswordFailed(message: error.toString(), isLoading: false));
      }
    });

    on<ClearLoginData>((event, emit) async {
      emit(const LoginState());
    });
  }
}
