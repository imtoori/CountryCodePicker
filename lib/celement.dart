import 'package:flutter/foundation.dart';

/// Country element. This is the element that contains all the information
class CElement {
  /// the name of the country
  String name;

  /// the flag of the country
  String flag;

  /// the country code (IT,AF..)
  String code;

  /// the dial code (+39,+93..)
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
