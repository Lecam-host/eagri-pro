import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eagri_pro/features/auth/register/bloc/register_event.dart';
import 'package:eagri_pro/features/auth/register/bloc/register_state.dart';
import 'package:eagri_pro/core/models/http_response_model.dart';
import 'package:eagri_pro/features/profile/model/user_model.dart';
import 'package:eagri_pro/features/profile/service/user_service.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserService userService;

  RegisterBloc({required this.userService}) : super(const RegisterState()) {
    on<RegisterButtonPressed>((event, emit) async {
      emit(const RegisterState(isLoading: true));
      try {
        HttpResponseModel<dynamic> registerResponse = await userService.create(
            email: event.email, password: event.password);
        if (registerResponse.data != null) {
          HttpResponseModel<dynamic> loginResponse = await userService.login(
              email: event.email, password: event.password);
          if (loginResponse.data != null) {
            // await FirebaseService.sendMail(
            //     toMail: event.email,
            //     subject: LocaleKeys.welcome_subject.tr(),
            //     text: LocaleKeys.welcome_text.tr());
            HttpResponseModel<dynamic> validateResponse =
                await userService.validate(token: loginResponse.data);
            await userService.saveAuthTokenToSP(loginResponse.data);
            final user = UserModel.fromMap(validateResponse.data);
            emit(RegisterSuccess(
                user: user,
                message: validateResponse.message,
                isLoading: false));
          } else {
            emit(RegisterState(
                isLoading: false, message: loginResponse.message));
          }
        } else {
          emit(RegisterState(
              isLoading: false, message: registerResponse.message));
        }
      } catch (error) {
        emit(RegisterFailed(message: error.toString(), isLoading: false));
      }
    });

    on<CheckButtonPressed>((event, emit) async {
      emit(const RegisterState(isLoading: true));
      try {
        HttpResponseModel<dynamic> checkResponse =
            await userService.check(email: event.email);
        if (checkResponse.data != null) {
          if (!checkResponse.data) {
            // int? verificationCode =
            //     await FirebaseService.sendVerificationCode(toMail: event.email);
            emit(
              CheckSuccess(
                email: event.email,
                password: event.password,
                verificationCode: 1,
                isLoading: false,
                message: checkResponse.message,
                data: checkResponse.data,
              ),
            );
          } else {
            emit(
              CheckSuccess(
                email: event.email,
                password: event.password,
                isLoading: false,
                data: checkResponse.data,
                message: checkResponse.message,
              ),
            );
          }
        }
      } catch (error) {
        emit(CheckFailed(
            message: error.toString(), isLoading: false, data: null));
      }
    });

    on<ForgotPasswordButtonPressed>((event, emit) async {
      emit(const RegisterState(isLoading: true));
      try {
        HttpResponseModel<dynamic> checkResponse =
            await userService.check(email: event.email);
        if (checkResponse.data != null) {
          if (checkResponse.data) {
            // int? verificationCode =
            //     await FirebaseService.sendVerificationCode(toMail: event.email);
            emit(
              ForgotPasswordCheckSuccess(
                email: event.email,
                verificationCode: 1,
                isLoading: false,
                data: checkResponse.data,
                message: checkResponse.message,
              ),
            );
          } else {
            emit(
              ForgotPasswordCheckFailed(
                message: checkResponse.message,
                isLoading: false,
                data: checkResponse.data,
              ),
            );
          }
        }
      } catch (error) {
        emit(CheckFailed(
            message: error.toString(), isLoading: false, data: null));
      }
    });

    on<ClearRegisterData>((event, emit) async {
      emit(const RegisterState());
    });
  }
}
