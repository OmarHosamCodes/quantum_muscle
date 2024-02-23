import 'package:quantum_muscle/library.dart';

class LocaleState {
  LocaleState({required this.locale});
  final String locale;

  LocaleState copyWith({
    String? locale,
  }) {
    return LocaleState(
      locale: locale ?? this.locale,
    );
  }
}

class LocaleProvider extends StateNotifier<LocaleState> {
  LocaleProvider()
      : super(
          LocaleState(
            locale: Hive.box<String>('localization').get('language') ??
                SimpleConstants.englishLocale,
          ),
        );

  void toggleLocale() {
    final locale = state.locale == SimpleConstants.englishLocale
        ? SimpleConstants.arabicLocale
        : SimpleConstants.englishLocale;
    Hive.box<String>('localization').put('language', locale);
    state = state.copyWith(locale: locale);
  }
}

final localeProvider = StateNotifierProvider<LocaleProvider, LocaleState>(
  (ref) => LocaleProvider(),
);
