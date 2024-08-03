import 'package:flutter/material.dart';

abstract class CustomShapes {
  static MaterialStateProperty<OutlinedBorder?> kPrimaryButtonRadius =
      MaterialStateProperty.all(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(28),
  ));

  static InputBorder kPrimaryTextFieldRadius = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
  );

  static BorderRadius kPrimaryRadius = BorderRadius.circular(8.0);
}
