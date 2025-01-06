import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:eagri_pro/core/utils/router/routes.dart';
import 'package:eagri_pro/features/auth/register/bloc/register_bloc.dart';
import 'package:eagri_pro/features/auth/register/bloc/register_event.dart';
import 'package:eagri_pro/features/auth/register/bloc/register_state.dart';
import 'package:eagri_pro/features/profile/bloc/profile_bloc.dart';
import 'package:eagri_pro/features/profile/bloc/profile_event.dart';
import 'package:eagri_pro/features/theme/bloc/theme_bloc.dart';
import 'package:eagri_pro/features/theme/bloc/theme_state.dart';
import 'package:eagri_pro/generated/locale_keys.g.dart';
import 'package:eagri_pro/common/helpers/app_helper.dart';
import 'package:eagri_pro/features/auth/verify/widget/verification_code_text_field.dart';

import '../../components/auth_header.dart';
part "verify_view_mixin.dart";

class VerifyView extends StatefulWidget {
  const VerifyView({super.key});

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> with VerifyViewMixin {
  @override
  Widget build(BuildContext context) {
    final RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, registerState) {
            return BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {
                _listener(state);
              },
              child: Scaffold(
                body: SafeArea(
                  child: PopScope(
                    canPop: !registerState.isLoading,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          AuthHeaderWidget(
                            title: LocaleKeys.verification_code.tr(),
                            subtitle:
                                LocaleKeys.enter_verification_code_prefix.tr(),
                          ),
                          // Text(
                          //   LocaleKeys.enter_verification_code_prefix.tr(),
                          //   style: TextStyle(
                          //     color: themeState.isDark
                          //         ? ColorConstants.lightTextField
                          //         : ColorConstants.darkTextField,
                          //   ),
                          // ).tr(),
                          const SizedBox(height: 30),
                          (registerState is CheckSuccess ||
                                  registerState is ForgotPasswordCheckSuccess)
                              ? Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: LocaleKeys
                                                  .enter_verification_code_prefix
                                                  .tr()),
                                          TextSpan(
                                              text: registerState
                                                      is CheckSuccess
                                                  ? registerState.email
                                                  : registerState
                                                          is ForgotPasswordCheckSuccess
                                                      ? registerState.email
                                                      : "",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: LocaleKeys
                                                  .enter_verification_code_suffix
                                                  .tr()),
                                        ],
                                        style: TextStyle(
                                          color: themeState.isDark
                                              ? CupertinoColors.white
                                              : CupertinoColors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                )
                              : const SizedBox(),
                          VerificationCodeTextField(
                            enabled: !registerState.isLoading,
                            textEditingController:
                                _verificationCodeTextEditingController,
                            onPressed: () async {
                              context
                                  .pushReplacement(Routes.updatePassword.path);
                              // await _register(
                              //     registerState: registerState,
                              //     registerBloc: registerBloc);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
