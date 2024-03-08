import 'package:quantum_muscle/library.dart';

/// A utility class that provides various helper methods and properties.
class Utils {
  /// Returns the instance of [FirebaseAuth].
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  /// Returns the instance of [FirebaseFirestore].
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  /// Returns the collection reference for the 'users' collection.
  CollectionReference get usersCollection =>
      firebaseFirestore.collection(DBPathsConstants.usersPath);

  /// Returns the collection reference for the 'programs' collection.
  CollectionReference get programsCollection =>
      firebaseFirestore.collection(DBPathsConstants.programsPath);

  /// Returns the collection reference for the 'chats' collection.
  CollectionReference get chatsCollection =>
      firebaseFirestore.collection(DBPathsConstants.chatsPath);

  /// Returns the collection reference for the 'public' collection.
  CollectionReference get publicCollection =>
      firebaseFirestore.collection(DBPathsConstants.publicPath);

  /// Returns the reference to the Firebase Storage.
  Reference get firebaseStorage => FirebaseStorage.instance.ref();

  /// Returns the instance of [FirebaseAnalytics].
  FirebaseAnalytics get firebaseAnalytics => FirebaseAnalytics.instance;

  /// Returns the currently authenticated user.
  User? get user => firebaseAuth.currentUser;

  /// Returns the UID of the currently authenticated user.
  String? get userUid => user?.uid;

  /// Returns the current locale.
  String get locale => Intl.getCurrentLocale();

  /// Returns `true` if the current locale is English, `false` otherwise.
  bool get isEnglish => locale == SimpleConstants.englishLocale;

  /// Returns the string '1' if the current locale is English, an empty string otherwise.
  String get isOneExist => isEnglish ? '1' : SimpleConstants.emptyString;

  /// Returns a string representing the time elapsed since the given [timestamp].
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

  /// Allows the user to choose an image from the device's storage.
  /// Returns the base64-encoded image data as a [String].
  Future<String?> chooseImageFromStorage() async {
    XFile? image;
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (_) {
      return null;
    }
    if (image != null) {
      if (kIsWeb) {
        final imageXFile = XFile(image.path);
        return base64Encode(await imageXFile.readAsBytes());
      } else {
        if (await Permission.storage.isDenied) {
          await Permission.storage.request();
        }
        final imageFile = File(image.path);
        return base64Encode(await imageFile.readAsBytes());
      }
    }
    return null;
  }

  /// Copies the given [text] to the device's clipboard.
  Future<void> copyToClipboard({required String text}) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
