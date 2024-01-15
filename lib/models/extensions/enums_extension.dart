extension GetName on Enum {
  String get name => toString().split('.').last;
}
