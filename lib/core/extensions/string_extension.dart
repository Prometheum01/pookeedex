import 'package:kartal/kartal.dart';

extension StringExt on String {
  String get idForFronted {
    switch (length) {
      case 1:
        return "#00$this";
      case 2:
        return "#0$this";
      case 3:
        return "#$this";
      default:
        return "#$this";
    }
  }

  String get pookeeId => split("/")[split("/").length - 2];

  String get toJsonText => replaceAll(' ', '-').toLowerCase();

  String get fromJsonText => replaceAll('-', ' ').toCapitalized();
}
