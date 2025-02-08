import 'package:flutter/material.dart';

class GenericUtils {
  //========================================================================
  // Responsive Utils
  //========================================================================

  /// Calculating current Platform according dimensions of the device
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  /// Calculating current Platform according dimensions of the device
  static bool isTablet(BuildContext context) =>
      (MediaQuery.of(context).size.width < 1100 &&
          MediaQuery.of(context).size.width >= 850);

  /// Calculating current Platform according dimensions of the device
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;
}
