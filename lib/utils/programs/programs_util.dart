import '/library.dart';

final programImageBytesProvider = StateProvider<Uint8List?>((ref) => null);

class ProgramsUtil extends Utils {
  static get instance => ProgramsUtil();
}
