import '/library.dart';

enum MessageType {
  text,
  image,
  video,
  audio,
  file,
  request,
  server,
}

extension MessageTypeExtension on MessageType {
  String get name {
    switch (this) {
      case MessageType.text:
        return MessageTypeConstants.text;
      case MessageType.image:
        return MessageTypeConstants.image;
      case MessageType.video:
        return MessageTypeConstants.video;
      case MessageType.audio:
        return MessageTypeConstants.audio;
      case MessageType.file:
        return MessageTypeConstants.file;
      case MessageType.request:
        return MessageTypeConstants.request;
      case MessageType.server:
        return MessageTypeConstants.server;
    }
  }
}
