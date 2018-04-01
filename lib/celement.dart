class CElement {
  String name;
  String flag;
  String code;
  String dialCode;

  CElement({this.name, this.flag, this.code, this.dialCode});

  @override
  String toString() {
    return "$flag $dialCode";
  }

  String toLongString() {
    return "$flag $dialCode $name";
  }
}