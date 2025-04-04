import 'package:flutter/material.dart';

extension on String {
  String? toCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

// marginOnly
extension MarginOnly on Widget {
  Widget marginOnly({double left = 0, double right = 0, double top = 0, double bottom = 0}) {
    return Container(
      margin: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: this,
    );
  }
}
