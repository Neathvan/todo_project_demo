import 'package:flutter/material.dart';
import 'package:todo_project_demo/helper/colors.dart';

extension KTextTheme on TextTheme {
  /// BLACK
  TextStyle get black13 =>
      const TextStyle(fontSize: 13, fontWeight: FontWeight.w400);
  TextStyle get black13Bold => black13.copyWith(fontWeight: FontWeight.bold);
  TextStyle get black15Bold => black13Bold.copyWith(fontSize: 15);
  TextStyle get black17Bold => black13Bold.copyWith(fontSize: 17);

  /// RED
  TextStyle get red13Bold => black13Bold.copyWith(color: KColors.red);

  /// BLUE
  TextStyle get blue13 => black13.copyWith(color: KColors.blue);

  /// GREEN
  TextStyle get green13Bold => black13Bold.copyWith(color: KColors.green);

  /// WHITE
  TextStyle get white13 => black13.copyWith(color: KColors.white);
}

extension NumberExtention on num {
  Widget get width => SizedBox(width: toDouble());
  Widget get height => SizedBox(height: toDouble());
}

class Measure {
  static int paddingLevel1 = 16;
  static var paddingLevel2 = 8;
  static var borderRaduisl1 = 5.0;
}
