import '/library.dart';

class Utils {
  static Utils get instants => Utils();
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;
  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;
  User? get user => firebaseAuth.currentUser;
  bool get isUserNull => user == null;
  String? get userUid => user!.uid;
  String? get userRatID => userUid!.substring(0, 16);
  String get locale => Intl.getCurrentLocale();
  bool get isEnglish => locale == SimpleConstants.englishLocale;
  bool get isArabic => locale == SimpleConstants.arabicLocale;
  String get isOneExist => isEnglish ? '1' : SimpleConstants.emptyString;

  void toggleLocale(WidgetRef ref) {
    isEnglish
        ? ref.read(localeStateProvider.notifier).state =
            const Locale(SimpleConstants.arabicLocale)
        : ref.read(localeStateProvider.notifier).state =
            const Locale(SimpleConstants.englishLocale);
  }

  String timeAgo(Timestamp timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp.toDate());
    switch (difference.inSeconds) {
      case < 60:
        return S.current.JustNow;
      case < 3600:
        final minutes = difference.inMinutes;
        return minutes == 1
            ? '$isOneExist ${S.current.MinuteAgo}'
            : '$minutes ${S.current.MinutesAgo}';
      case < 86400:
        final hours = difference.inHours;
        return hours == 1
            ? '$isOneExist ${S.current.HourAgo}'
            : '$hours ${S.current.HoursAgo}';
      case < 2592000:
        final days = difference.inDays;
        return days == 1
            ? '$isOneExist ${S.current.DayAgo}'
            : '$days ${S.current.DaysAgo}';
      case < 31536000:
        final months = (difference.inDays / 30).floor();
        return months == 1
            ? '$isOneExist ${S.current.MonthAgo}'
            : '$months ${S.current.MonthsAgo}';
      default:
        final years = (difference.inDays / 365).floor();
        return years == 1
            ? '$isOneExist ${S.current.YearAgo}'
            : '$years ${S.current.YearsAgo}';
    }
  }
}
