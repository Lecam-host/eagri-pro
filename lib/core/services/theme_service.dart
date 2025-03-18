import 'package:eagri_pro/core/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/theme/bloc/theme_bloc.dart';
import '../../features/theme/bloc/theme_event.dart';
import '../../features/theme/bloc/theme_state.dart';
import 'shared_preferences_service.dart';

class ThemeService {
  static bool useDeviceTheme = true;
  static bool isDark = false;

  static void initialize(BuildContext context) {
    ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = ThemeService.isDark;
    if (ThemeService.useDeviceTheme) {
      isDarkMode = brightness == Brightness.dark;
    }
    themeBloc.add(ChangeTheme(
        useDeviceTheme: ThemeService.useDeviceTheme, isDark: isDarkMode));
  }

  static void autoChangeTheme(BuildContext context) async {
    ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);
    var brightness = MediaQuery.of(context).platformBrightness;
    ThemeService.getTheme();
    bool isDarkMode = ThemeService.isDark;
    if (ThemeService.useDeviceTheme) {
      isDarkMode = brightness == Brightness.dark;
    }
    themeBloc.add(ChangeTheme(
        useDeviceTheme: ThemeService.useDeviceTheme, isDark: isDarkMode));
  }

  static Future<void> setTheme(
      {required bool useDeviceTheme, required bool isDark}) async {
    await SharedPreferencesService.instance
        .setData(PreferenceKey.useDeviceTheme, useDeviceTheme);
    await SharedPreferencesService.instance
        .setData(PreferenceKey.isDark, isDark);
  }

  static void getTheme() {
    useDeviceTheme = SharedPreferencesService.instance
            .getData(PreferenceKey.useDeviceTheme) ??
        true;
    isDark = SharedPreferencesService.instance.getData(PreferenceKey.isDark) ??
        false;
  }

  static ThemeData buildTheme(ThemeState state) {
    final brightness = state.isDark ? Brightness.dark : Brightness.light;
    return ThemeData(
      brightness: brightness,
      primaryColor: ColorConstants.primaryColor,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(ColorConstants.primaryColor.value, {
          50: ColorConstants.primaryColor.withOpacity(0.1),
          100: ColorConstants.primaryColor.withOpacity(0.2),
          200: ColorConstants.primaryColor.withOpacity(0.3),
          300: ColorConstants.primaryColor.withOpacity(0.4),
          400: ColorConstants.primaryColor.withOpacity(0.5),
          500: ColorConstants.primaryColor.withOpacity(0.6),
          600: ColorConstants.primaryColor.withOpacity(0.7),
          700: ColorConstants.primaryColor.withOpacity(0.8),
          800: ColorConstants.primaryColor.withOpacity(0.9),
          900: ColorConstants.primaryColor,
        }),
        brightness: brightness,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: CupertinoDynamicColor.withBrightness(
          color: lightColor,
          darkColor: darkColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            TextStyle(
              fontFamily: fontFamily,
              color: ColorConstants.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      textTheme: TextTheme(
        labelLarge: TextStyle(
          fontSize: 16,
          fontFamily: fontFamily,
          color: CupertinoDynamicColor.withBrightness(
            color: lightColor,
            darkColor: darkColor,
          ),
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          fontSize: 14,
          fontFamily: fontFamilySecond,
          color: CupertinoDynamicColor.withBrightness(
            color: lightColor,
            darkColor: darkColor,
          ),
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          fontFamily: fontFamily,
          color: CupertinoDynamicColor.withBrightness(
            color: lightColor,
            darkColor: darkColor,
          ),
          fontWeight: FontWeight.w500,
        ),
        headlineMedium: TextStyle(
            fontSize: 20,
            fontFamily: fontFamily,
            color: CupertinoDynamicColor.withBrightness(
              color: lightColor,
              darkColor: darkColor,
            )),
        titleMedium: TextStyle(
          fontSize: 16,
          fontFamily: fontFamily,
          color: CupertinoDynamicColor.withBrightness(
            color: lightColor,
            darkColor: darkColor,
          ),
          fontWeight: FontWeight.w500,
        ),
        displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 35,
          color: CupertinoDynamicColor.withBrightness(
            color: lightColor,
            darkColor: darkColor,
          ),
        ),
        displaySmall: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: CupertinoDynamicColor.withBrightness(
            color: lightColor,
            darkColor: darkColor,
          ),
        ),
        displayMedium: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: CupertinoDynamicColor.withBrightness(
            color: lightColor,
            darkColor: darkColor,
          ),
        ),
        titleSmall: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: CupertinoDynamicColor.withBrightness(
            color: lightColor,
            darkColor: darkColor,
          ),
        ),
        titleLarge: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: CupertinoDynamicColor.withBrightness(
            color: lightColor,
            darkColor: darkColor,
          ),
        ),
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          color: CupertinoDynamicColor.withBrightness(
            color: lightColor,
            darkColor: darkColor,
          ),
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          color: CupertinoDynamicColor.withBrightness(
            color: lightColor,
            darkColor: darkColor,
          ),
        ),
      ),
    );
  }
}

String fontFamily = "BwGradual";
String fontFamilySecond = "Inter";
Color lightColor = CupertinoColors.black;
Color darkColor = CupertinoColors.white;
