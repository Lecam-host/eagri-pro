import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/components/custom_text_field.dart';
import '../../../../common/helpers/app_helper.dart';
import '../../../../core/models/http_response_model.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../theme/bloc/theme_bloc.dart';
import '../../../theme/bloc/theme_state.dart';
import '../../register/bloc/register_bloc.dart';
import '../../register/bloc/register_event.dart';
import '../../register/bloc/register_state.dart';
part "forgot_password_view_mixin.dart";

class ForgotPasswordView extends StatelessWidget with ForgotPasswordViewMixin {
  final TextEditingController textEditingController;
  final void Function(RegisterState registerState) forgotPasswordListener;
  const ForgotPasswordView(
      {super.key,
      required this.textEditingController,
      required this.forgotPasswordListener});

  @override
  Widget build(BuildContext context) {
    final RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, registerState) {
            return BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {
                forgotPasswordListener(state);
              },
              child: SafeArea(
                bottom: false,
                child: Scaffold(
                  body: PopScope(
                    canPop: !registerState.isLoading,
                    child: Column(children: [
                      const Text(LocaleKeys.forgot_password_text).tr(),
                      const SizedBox(height: 10),
                      CustomTextField(
                        enabled: !registerState.isLoading,
                        textEditingController: textEditingController,
                        placeholder: LocaleKeys.email.tr(),
                        prefixIcon: CupertinoIcons.mail,
                        keyboardType: TextInputType.emailAddress,
                        onSubmitted: (p0) {
                          _onSubmit(
                              context, textEditingController, registerBloc);
                        },
                        suffix: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            _onSubmit(
                                context, textEditingController, registerBloc);
                          },
                          child: !registerState.isLoading
                              ? const Icon(CupertinoIcons.arrow_right_circle)
                              : const CupertinoActivityIndicator(),
                        ),
                      ),
                    ]),
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
