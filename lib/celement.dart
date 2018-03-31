class CElement {
  String name;
  String flag;
  String code;
  String dial_code;

  CElement({this.name, this.flag, this.code, this.dial_code});

  @override
  String toString() {
    return "$flag $dial_code";
  }

  String toLongString() {
    return "$flag $dial_code $name";
  }
}