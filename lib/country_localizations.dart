import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountryLocalizations {
  final Locale locale;

  CountryLocalizations(this.locale);

  static CountryLocalizations? of(BuildContext context) {
    return Localizations.of<CountryLocalizations>(
      context,
      CountryLocalizations,
    );
  }

  static const _CountryLocalizationsDelegate delegate =
      _CountryLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String fileName = delegate.resolveLocale(locale);
    String jsonString = await rootBundle
        .loadString('packages/country_code_picker/i18n/$fileName.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String? translate(String? key) {
    return _localizedStrings[key!];
  }
}

class _CountryLocalizationsDelegate
    extends LocalizationsDelegate<CountryLocalizations> {
  const _CountryLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final codeWithCountry = '${locale.languageCode}' +
        (locale.countryCode == null ? '' : '-${locale.countryCode}');
    return supportedLocales.contains(codeWithCountry) ||
        supportedLocales.contains(locale.languageCode);
  }

  String resolveLocale(Locale locale) {
    final codeWithCountry = '${locale.languageCode}' +
        (locale.countryCode == null ? '' : '-${locale.countryCode}');
    if (supportedLocales.contains(codeWithCountry)) {
      return codeWithCountry;
    }
    if (supportedLocales.contains(locale.languageCode)) {
      return locale.languageCode;
    }
    return "en";
  }

  @override
  Future<CountryLocalizations> load(Locale locale) async {
    CountryLocalizations localizations = new CountryLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_CountryLocalizationsDelegate old) => false;

  static const supportedLocales = [
    "af",
    "am",
    "ar",
    "az",
    "be",
    "bg",
    "bn",
    "bs",
    "ca",
    "cs",
    "da",
    "de",
    "el",
    "en",
    "es",
    "et",
    "fa",
    "fi",
    "fr",
    "gl",
    "ha",
    "he",
    "hi",
    "hr",
    "hu",
    "hy",
    "id",
    "is",
    "it",
    "ja",
    "ka",
    "kk",
    "km",
    "ko",
    "ku",
    "ky",
    "lt",
    "lv",
    "mk",
    "ml",
    "mn",
    "ms",
    "nb",
    "nl",
    "nn",
    "no",
    "pl",
    "ps",
    "pt",
    "ro",
    "ru",
    "sd",
    "sk",
    "sl",
    "so",
    "sq",
    "sr",
    "sv",
    "ta",
    "tg",
    "th",
    "tk",
    "tr",
    "tt",
    "uk",
    "ug",
    "ur",
    "uz",
    "vi",
    "zh",
    "zh-CN",
    "zh-TW",
  ];
}
