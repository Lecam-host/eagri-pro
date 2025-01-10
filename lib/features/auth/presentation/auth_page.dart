import 'dart:developer';

import 'package:eagri_pro/common/components/button_custom.dart';
import 'package:eagri_pro/common/components/snack_bar_custom.dart';
import 'package:eagri_pro/features/auth/components/custom_header.dart';
import 'package:eagri_pro/features/auth/presentation/auth_mixin.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/components/custom_text_field.dart';
import '../../../../common/helpers/app_helper.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/models/http_response_model.dart';
import '../../../../core/utils/router/routes.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/utils/enum.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../theme/bloc/theme_state.dart';
import '../bloc/login/auth_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with AuthMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        LocaleKeys.login.tr().toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                      ),
                      // const SizedBox(height: 8),
                      Text(
                        LocaleKeys.connect_your_account.tr(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      const SizedBox(height: 40),
                      TextFieldCustom(
                        label: "Numéro de téléphone ou Username",
                        controller: phoneNumberTextEditingController,
                        hintText: "Entrez votre login",
                        prefixIcon: const Icon(Icons.phone_outlined),
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z0-9]")),
                          // LengthLimitingTextInputFormatter(10),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFieldCustom(
                        label: "Mot de passe",
                        hintText: "Entrez votre mot de passe",
                        controller: passwordTextEditingController,
                        prefixIcon: const Icon(Icons.lock_outline),
                        obscureText: true,
                        // textInputAction: TextInputAction.done,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () =>
                              context.pushNamed(Routes.forgotPassword.path),
                          child: Text(
                            "Mot de passe oublié ?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: ColorConstants.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state.stateStatus == Status.success) {
                            SnackBarCustom.show(
                              context: context,
                              message: "Connexion réussie !",
                              type: SnackBarType.success,
                            );
                            if (mounted) {
                              context.go(Routes.home.path);
                            }
                          }
                          if (state.stateStatus == Status.error) {
                            SnackBarCustom.show(
                              context: context,
                              message: state.errorMessage ??
                                  "Une erreur est survenue",
                              type: SnackBarType.error,
                            );
                          }
                        },
                        builder: (context, state) {
                          return ButtonCustom(
                            label: 'Se connecter',
                            isLoading: state.stateStatus == Status.loading,
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                    SendRequestLogin(
                                      username: phoneNumberTextEditingController
                                          .text
                                          .trim(),
                                      password: passwordTextEditingController
                                          .text
                                          .trim(),
                                    ),
                                  );
                            },
                            backgroundColor: ColorConstants.primaryColor,
                            textColor: Colors.white,
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Vous n'avez pas de compte ?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "S'inscrire",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: ColorConstants.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
