import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/components/custom_text_field.dart';
import '../../../../common/helpers/app_helper.dart';
import '../../../../core/models/http_response_model.dart';
import '../../../../core/utils/router/routes.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../theme/bloc/theme_bloc.dart';
import '../../../theme/bloc/theme_state.dart';
import '../../components/auth_header.dart';
import '../../login/bloc/login_bloc.dart';
import '../../login/bloc/login_event.dart';
import '../../login/bloc/login_state.dart';
import '../../register/bloc/register_bloc.dart';
import '../../register/bloc/register_state.dart';
import '../widget/update_password_button.dart';
part "update_password_view_mixin.dart";

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({super.key});

  @override
  State<UpdatePasswordView> createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView>
    with UpdatePasswordViewMixin {
  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, registerState) {
            return BlocBuilder<LoginBloc, LoginState>(
              builder: (context, loginState) {
                return BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    _listener(state);
                  },
                  child: SafeArea(
                    child: Scaffold(
                      body: PopScope(
                        canPop: !loginState.isLoading,
                        child: Column(
                          children: [
                            AuthHeaderWidget(
                              title: LocaleKeys.change_password.tr(),
                              subtitle: LocaleKeys.enter_new_password.tr(),
                              showBackButton: true,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              textEditingController:
                                  _newPasswordTextEditingController,
                              prefixIcon: CupertinoIcons.lock,
                              placeholder: LocaleKeys.password.tr(),
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              enabled: !loginState.isLoading,
                              onSubmitted: (loginState.isLoading ||
                                      registerState.message == null)
                                  ? null
                                  : (p0) {
                                      _updateButtonOnPressed(
                                          loginBloc: loginBloc,
                                          registerState: registerState);
                                    },
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              textEditingController:
                                  _newPasswordTextEditingController,
                              prefixIcon: CupertinoIcons.lock,
                              placeholder: LocaleKeys.confirm_password.tr(),
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              enabled: !loginState.isLoading,
                              onSubmitted: (loginState.isLoading ||
                                      registerState.message == null)
                                  ? null
                                  : (p0) {
                                      _updateButtonOnPressed(
                                          loginBloc: loginBloc,
                                          registerState: registerState);
                                    },
                            ),
                            const SizedBox(height: 20),
                            UpdatePasswordButton(
                              isLoading: loginState.isLoading,
                              onPressed: (loginState.isLoading ||
                                      registerState.message == null)
                                  ? null
                                  : () {
                                      _updateButtonOnPressed(
                                          loginBloc: loginBloc,
                                          registerState: registerState);
                                    },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
