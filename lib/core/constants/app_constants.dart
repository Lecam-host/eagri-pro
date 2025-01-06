import 'package:easy_localization/easy_localization.dart';

import '../../generated/locale_keys.g.dart';

class AppConstants {
  static final DateFormat dateformat = DateFormat('dd.MM.yyyy');
  static final DateTime nullDate =
      DateTime.parse("0001-01-01T00:00:00Z").toUtc();
  static final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  // Password must contain at least one uppercase letter, one lowercase letter, one number and must be at least 8 characters long
  static final passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  static List<int> genders = [1, 2, 3];

  static String getGender(int value) {
    switch (value) {
      case 1:
        return LocaleKeys.type_male.tr();
      case 2:
        return LocaleKeys.type_female.tr();
      case 3:
        return LocaleKeys.type_i_dont_want_to_specify.tr();
      default:
        return LocaleKeys.type_i_dont_want_to_specify.tr();
    }
  }

  static double defaultPadding = 16.0;
  static double defaultBorderRadious = 12.0;
  static Duration defaultDuration = const Duration(milliseconds: 300);
  static const double borderRadius = 10;
}

const Duration defaultDuration = Duration(milliseconds: 300);
const double borderRadius = 10;
const double defaultBorderRadious = 12.0;
const double defaultPadding = 16.0;


abstract class ConstantUrl {
  static const String gateway = 'http://84.247.170.134:8000';
  static const String apiVersion = '/api/v1';
  static const String baseUrl = '$gateway$apiVersion';
  static const String msSecurity = '/security';
  static const String msCatalogue = '/catalog';
  static const String msMicroInsurance = '/micro-credit-insurance';
  static const String msArticle = '/article';
  static const String msAdvice = '/advice';
  static const String msAlerte = '/alerts';
  static const String msOrder = '/order';
  static const String msFavorite = '/customer/favorite';
  static const String msPayment = '/payment';
  static const String msNotification = '/notification';
  static const String msConfig = "/configuration";
  static const String msPrice = "/price";
  static const String msLocation = "/location";

  static const String weather = "/weather";
  static const String article = "/article";
  static const String msPurchase = "/purchase";
}
