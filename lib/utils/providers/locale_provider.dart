import 'package:quantum_muscle/library.dart';

class LocaleProvider extends StateNotifier<String> {
  LocaleProvider()
      : super(
          Hive.box<String>('localization').get('language')!,
        );

  void toggleLocale() {
    if (state == SimpleConstants.englishLocale) {
      state = SimpleConstants.arabicLocale;
      Hive.box<String>('localization')
          .put('language', SimpleConstants.arabicLocale);
    } else {
      state = SimpleConstants.englishLocale;
      Hive.box<String>('localization')
          .put('language', SimpleConstants.englishLocale);
    }
  }
}

final localeProvider = StateNotifierProvider<LocaleProvider, String>(
  (ref) => LocaleProvider(),
);
