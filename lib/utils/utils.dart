import '/library.dart';

class Utils {
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;
  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;
  User? get user => firebaseAuth.currentUser;
  String? get userUid => user!.uid;
  String get locale => Intl.getCurrentLocale();
  bool get isEnglish => locale == SimpleConstants.englishLocale;
  String get isOneExist => isEnglish ? '1' : SimpleConstants.emptyString;

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

  Future<void> chooseImageFromStorage(
      {required WidgetRef ref,
      required StateProvider<String?> provider}) async {
    late XFile? image;

    image = await ImagePicker().pickImage(source: ImageSource.gallery) ??
        XFile.fromData(Uint8List(0));

    if (kIsWeb) {
      final imageXFile = XFile(image.path);
      ref.read(provider.notifier).state =
          base64Encode(await imageXFile.readAsBytes());
    } else {
      if (await Permission.storage.isDenied) {
        await Permission.storage.request();
      }
      final imageFile = File(image.path);

      ref.read(provider.notifier).state =
          base64Encode(await imageFile.readAsBytes());
    }
  }

  Future<void> copyToClipboard({required String text}) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
