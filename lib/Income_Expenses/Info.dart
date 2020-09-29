import 'categoryinfo.dart';

class IncInfo {
  final ICategory type;
  final String value;
  IncInfo({this.type, this.value});
}

class ExpInfo {
  final ECategory type;
  final String value;
  ExpInfo({this.type, this.value});
}

List<IncInfo> incom = [
  IncInfo(type: salary, value: "1000"),
  IncInfo(type: salary, value: "1000"),
  IncInfo(type: salary, value: "1000"),
  IncInfo(type: salary, value: "1000"),
  IncInfo(type: salary, value: "1000"),
];

List<ExpInfo> expens = [
  ExpInfo(
    type: rent,
    value: "500",
  ),
  ExpInfo(
    type: rent,
    value: "500",
  ),
  ExpInfo(
    type: rent,
    value: "500",
  ),
  ExpInfo(
    type: rent,
    value: "500",
  ),
  ExpInfo(
    type: rent,
    value: "500",
  ),
  ExpInfo(
    type: rent,
    value: "500",
  ),
];
