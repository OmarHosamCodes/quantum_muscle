import 'package:quantum_muscle/library.dart';

/// This file contains the implementation of the `LocaleState` and `LocaleProvider` classes.
///
/// The `LocaleState` class represents the state of the locale in the application. It contains a `locale` property which is a string representing the current locale.
///
/// The `LocaleProvider` class is a `StateNotifier` that manages the state of the locale in the application. It extends the `StateNotifier` class from the `flutter_riverpod` package.
///
/// The `LocaleProvider` class initializes the initial state of the locale using the `LocaleState` class. It also provides a method `toggleLocale` to toggle between English and Arabic locales.
///
/// The `localeProvider` is a `StateNotifierProvider` that provides an instance of the `LocaleProvider` class and the `LocaleState` class to be used by other parts of the application.
///
/// Example usage:
/// ```dart
/// final localeProvider = useProvider(localeProvider);
/// print(localeProvider.state.locale); // Prints the current locale
/// localeProvider.toggleLocale(); // Toggles the locale between English and Arabic
/// ```
/// Represents the state of the locale in the application.
class LocaleState {
  /// Represents the state of the locale in the application.
  LocaleState({required this.locale});

  /// The current locale.
  final String locale;

  /// Creates a copy of the `LocaleState` with the specified parameters overridden.
  LocaleState copyWith({
    String? locale,
  }) {
    return LocaleState(
      locale: locale ?? this.locale,
    );
  }
}

/// Notifier for managing the state of the locale in the application.
class LocaleProvider extends StateNotifier<LocaleState> {
  /// Manages the state of the locale in the application.
  LocaleProvider()
      : super(
          LocaleState(
            locale: Hive.box<String>('localization').get('language') ??
                SimpleConstants.englishLocale,
          ),
        );

  /// Toggles the locale between English and Arabic.
  void toggleLocale() {
    final locale = state.locale == SimpleConstants.englishLocale
        ? SimpleConstants.arabicLocale
        : SimpleConstants.englishLocale;
    Hive.box<String>('localization').put('language', locale);
    state = state.copyWith(locale: locale);
  }
}

/// Provides an instance of the `LocaleProvider` class and the `LocaleState` class to be used by other parts of the application.
final localeProvider = StateNotifierProvider<LocaleProvider, LocaleState>(
  (ref) => LocaleProvider(),
);
