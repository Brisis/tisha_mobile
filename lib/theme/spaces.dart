import 'package:flutter/material.dart';

abstract class CustomSpaces {
  static SizedBox verticalSpace({double height = 8.0}) {
    return SizedBox(height: height);
  }

  static SizedBox horizontalSpace({double width = 8.0}) {
    return SizedBox(width: width);
  }
}
