import '/library.dart';

extension ObjectExtension on Object {
  void log() {
    if (kDebugMode) {
      print(this);
    }
  }
}
