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
    return ThemeData(
        // brightness: Brightness.light,
        brightness: state.isDark ? Brightness.dark : Brightness.light,
        primaryColor: state.isDark ? Colors.black : Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: CupertinoDynamicColor.withBrightness(
            color: lightColor,
            darkColor: darkColor,
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
            //fontFamily: fontFamily,
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
        )
        // listTileTheme: const ListTileThemeData(
        //     textColor: Colors.black,
        //     style: ListTileStyle.drawer,
        //     iconColor: Colors.black),
        // appBarTheme: AppBarTheme(
        //   titleSpacing: 0,
        //   elevation: 2,
        //   toolbarHeight: 100,
        //   centerTitle: true,
        //   surfaceTintColor: ConstantColors.grayScale200,
        //   systemOverlayStyle: SystemUiOverlayStyle.light,
        //   backgroundColor: ConstantColors.grayScale200,
        //   titleTextStyle: TextStyle(
        //     fontFamily: fontFamily,
        //     fontWeight: FontWeight.w700,
        //     fontSize: 19,
        //     color: Colors.black,
        //   ),
        // ),
        // scaffoldBackgroundColor: const Color.fromARGB(255, 247, 247, 247),

        // bottomAppBarTheme: const BottomAppBarTheme(
        //   color: Colors.white,
        // ),
        // colorScheme: const ColorScheme.light().copyWith(
        //   primary: ConstantColors.primary,
        //   secondary: ConstantColors.secondary,
        //   onPrimary: Colors.white,
        // ),
        // inputDecorationTheme: const InputDecorationTheme(
        //   isDense: true, // this will remove the default content padding
        //   // now you can customize it here or add padding widget
        //   contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        // ),
        // floatingActionButtonTheme: FloatingActionButtonThemeData(
        //   backgroundColor: ConstantColors.primary,
        //   foregroundColor: Colors.white,
        // ),
        // bottomSheetTheme: const BottomSheetThemeData(
        //   backgroundColor: Colors.transparent,
        // ),
        // radioTheme: RadioThemeData(
        //   fillColor: WidgetStateProperty.all(ConstantColors.primary),
        // ),
        // tabBarTheme: TabBarTheme(
        //   indicator: UnderlineTabIndicator(
        //     borderSide: BorderSide(
        //       color: ConstantColors.primary,
        //       width: 2,
        //     ),
        //   ),
        //   labelColor: ConstantColors.primary,
        //   unselectedLabelColor: Colors.black,
        //   labelStyle: TextStyle(
        //     color: ConstantColors.primary,
        //     fontFamily: fontFamily,
        //     // fontWeight: FontWeight.w700,
        //     fontSize: 15,
        //   ),
        //   unselectedLabelStyle: TextStyle(
        //     color: ConstantColors.primary,
        //     fontFamily: fontFamily,
        //     // fontWeight: FontWeight.w400,
        //     fontSize: 15,
        //   ),
        // ),
        // dialogTheme: DialogTheme(
        //   surfaceTintColor: Colors.white,
        //   contentTextStyle: TextStyle(
        //     color: Colors.black,
        //     fontFamily: fontFamily,
        //     // fontWeight: FontWeight.w400,
        //     fontSize: 20,
        //   ),
        //   titleTextStyle: TextStyle(
        //     color: Colors.black,
        //     fontFamily: fontFamily,
        //     // fontWeight: FontWeight.w700,
        //     fontSize: 20,
        //   ),
        // ),
        // cardTheme: const CardTheme(color: Colors.white),
        // shadowColor: Colors.grey.withOpacity(0.1),
        // textButtonTheme: TextButtonThemeData(
        //     style: ButtonStyle(
        //   textStyle: WidgetStateProperty.all(
        //     TextStyle(
        //       fontFamily: fontFamily,
        //       // fontWeight: FontWeight.w500,
        //       color: ConstantColors.primary,
        //       fontSize: 16,
        //     ),
        //   ),
        // )),
        // textTheme: ,
        );
    // CupertinoThemeData(
    //   brightness: state.isDark ? Brightness.dark : Brightness.light,
    //   primaryColor: CupertinoColors.systemBlue,
    //   barBackgroundColor: const CupertinoDynamicColor.withBrightness(
    //     color: CupertinoColors.lightBackgroundGray,
    //     darkColor: CupertinoColors.darkBackgroundGray,
    //   ),
    //   scaffoldBackgroundColor: CupertinoDynamicColor.withBrightness(
    //     color: ColorConstants.lightBackground,
    //     darkColor: ColorConstants.darkBackground,
    //   ),
    //   textTheme: const CupertinoTextThemeData(
    //     primaryColor: CupertinoDynamicColor.withBrightness(
    //       color: CupertinoColors.black,
    //       darkColor: CupertinoColors.white,
    //     ),
    //     textStyle: TextStyle(
    //       color: CupertinoDynamicColor.withBrightness(
    //         color: CupertinoColors.black,
    //         darkColor: CupertinoColors.white,
    //       ),
    //     ),
    //   ),
    // );
  }
}

String fontFamily = "Mulish";
Color lightColor = CupertinoColors.black;
Color darkColor = CupertinoColors.white;
