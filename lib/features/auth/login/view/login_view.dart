import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/components/custom_text_field.dart';
import '../../../../common/helpers/app_helper.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/models/http_response_model.dart';
import '../../../../core/utils/router/routes.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../profile/bloc/profile_bloc.dart';
import '../../../profile/bloc/profile_event.dart';
import '../../../theme/bloc/theme_bloc.dart';
import '../../../theme/bloc/theme_state.dart';
import '../../components/auth_header.dart';
import '../../password/view/forgot_password_view.dart';
import '../../register/bloc/register_state.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../widget/login_button.dart';
import '../widget/push_to_register_button.dart';
part "login_view_mixin.dart";

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginViewMixin {
  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    _listener(state);
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          AuthHeaderWidget(
                            title: LocaleKeys.login.tr(),
                            subtitle: LocaleKeys.connect_your_account.tr(),
                            showBackButton: false,
                          ),
                          // SizedBox(height: constraints.maxHeight * 0.1),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(children: [
                              const SizedBox(height: 40),
                              CustomTextField(
                                textEditingController:
                                    _emailTextEditingController,
                                enabled: !state.isLoading,
                                placeholder: LocaleKeys.email.tr(),
                                prefixIcon: CupertinoIcons.mail,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                textEditingController:
                                    _passwordTextEditingController,
                                placeholder: LocaleKeys.password.tr(),
                                textInputAction: TextInputAction.done,
                                enabled: !state.isLoading,
                                onSubmitted: (value) {
                                  _submit(loginBloc);
                                },
                                suffix: CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    _showForgotPasswordModalPopup();
                                  },
                                  child: Icon(
                                    CupertinoIcons.question_circle,
                                    color: themeState.isDark
                                        ? ColorConstants.darkSecondaryIcon
                                        : ColorConstants.lightSecondaryIcon,
                                  ),
                                ),
                                obscureText: true,
                                prefixIcon: CupertinoIcons.lock,
                              ),
                              const SizedBox(height: 20),
                              LoginButton(
                                isLoading: state.isLoading,
                                onPressed: () {
                                  context.go(Routes.navigation.path);

                                  // _submit(loginBloc);
                                },
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: () {
                                  context.push(Routes.verify.path);
                                },
                                child: Text(
                                  LocaleKeys.forgot_password.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: themeState.isDark
                                            ? ColorConstants.lightBackground
                                            : ColorConstants.darkSecondaryIcon,
                                      ),
                                ),
                              ),
                              const PushToRegisterButton()
                            ]),
                          ),
                          //  const TitleWidget(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
