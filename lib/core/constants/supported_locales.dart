import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../generated/locale_keys.g.dart';

class SuppertedLocales {
  static List<Locale> supportedLocales = const [Locale('en'), Locale('fr')];
  static List<Map<String, String>> supportedLanguages = [
    {"en": LocaleKeys.english.tr()},
    {"fr": LocaleKeys.french.tr()},
  ];
}
