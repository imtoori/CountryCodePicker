import 'package:flutter/foundation.dart';

class CElement {
  String name;
  String flag;
  String code;
  String dialCode;

  CElement({this.name, this.flag, this.code, this.dialCode});

  @override
  String toString() {
    return defaultTargetPlatform == TargetPlatform.android ? "$flag $dialCode" : dialCode;
  }

  String toLongString() {
    return defaultTargetPlatform == TargetPlatform.android ? "$flag $dialCode $name" : "$dialCode $name";
  }
}