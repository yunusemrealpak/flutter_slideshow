import 'dart:math';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get topPadding => MediaQuery.of(this).viewPadding.top;
  double get appbarHeight => AppBar().preferredSize.height;
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double get lowHeightValue => height * 0.01;
  double get normalHeightValue => height * 0.02;
  double get mediumHeightValue => height * 0.04;
  double get highHeightValue => height * 0.1;
  double customHeightValue(double value) => height * value;

  double get lowWidthValue => width * 0.01;
  double get normalWidthValue => width * 0.02;
  double get mediumWidthValue => width * 0.04;
  double get highWidthValue => width * 0.1;
  double customWidthValue(double value) => width * value;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowHeightValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalHeightValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumHeightValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highHeightValue);
  EdgeInsets get paddingHorizontalLow => EdgeInsets.symmetric(horizontal: lowHeightValue);
  EdgeInsets get paddingHorizontalNormal => EdgeInsets.symmetric(horizontal: normalHeightValue);
  EdgeInsets get paddingHorizontalHigh => EdgeInsets.symmetric(horizontal: highHeightValue);
}

extension PageExtension on BuildContext {
  Color get randomColor => Colors.primaries[Random().nextInt(17)];
}

extension DurationExtension on BuildContext {
  Duration get lowDuration => Duration(milliseconds: 750);
  Duration get normalDuration => Duration(seconds: 1);
}
